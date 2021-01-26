//
//  CustomViewClassTemplate.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/27.
//

import IBDecodable

final class CustomViewClassTemplate: RootClassBuilder {
    let className: String
    let id: String
    private var rootElement: CustomRootViewElement?
    private var subviews: [ViewElement] = []

    init(baseCustomViewClassName: String, id: String) {
        self.className = baseCustomViewClassName + "_XibSkeleton"
        self.id = id
    }

    func makeSubview(id: String, className: String, elementClass: String, userLabel: String?) -> ViewCodeBuilder {
        if self.id == id {
            let rootElement = CustomRootViewElement(
                id: id, className: className,
                elementClass: elementClass, userLabel: userLabel
            )
            self.rootElement = rootElement
            return rootElement
        }

        let subview = ViewElement(id: id, className: className, elementClass: elementClass, userLabel: userLabel)
        subviews.append(subview)
        return subview
    }

    func build<Target>(target: inout Target, context: inout CodeGenContext) throws where Target : IndentTextOutputStream {
        guard let rootElement = rootElement else { preconditionFailure() }

        target.writeLine { line in
            line.write("/// Generated from '\(id)'")
            if let userLabel = rootElement.userLabel {
                line.write(": \"\(userLabel)\"")
            }
        }

        target.writeLine("class \(className): \(rootElement.elementClass) {")

        let shouldWriteConstraintsActivation = subviews.contains(where: \.shouldWriteConstraintsActivation)
            || rootElement.shouldWriteConstraintsActivation
        try target.indented { target in
            for subview in subviews {
                try subview.build(target: &target, context: &context)
            }

            if shouldWriteConstraintsActivation {
                target.writeLine("func activateConstraints() {")
                try target.indented { target in
                    for subview in subviews {
                        try subview.buildConstraintsActivation(target: &target, context: &context)
                    }
                    try rootElement.buildConstraintsActivation(target: &target, context: &context)
                }
                target.writeLine("}")
            }

            try writeInit(target: &target, context: &context, shouldWriteConstraintsActivation: shouldWriteConstraintsActivation)
        }

        target.writeLine("}")
    }

    private func writeInit<Target>(target: inout Target, context: inout CodeGenContext,
                                   shouldWriteConstraintsActivation: Bool) throws where Target : IndentTextOutputStream {
        let coderInit = """
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        """

        for line in coderInit.split(whereSeparator: \.isNewline) {
            target.writeLine(String(line))
        }
        target.writeLine("\n")

        try rootElement?.writeInit(target: &target, context: &context, shouldWriteConstraintsActivation: shouldWriteConstraintsActivation)
    }
}

final class CustomRootViewElement: ViewCodeBuilder {
    let id: String
    let className: String
    let elementClass: String
    let userLabel: String?
    var shouldWriteConstraintsActivation: Bool { !constraints.isEmpty }
    private var properties: [String: (SwiftValueRepresentable, Availability?)] = [:]
    private var methodCalls: [(method: String, arguments: [Argument])] = []
    private var initArguments: [Argument] = []
    private var subviews: [ViewCodeBuilder] = []
    private var constraints: [Constraint] = []

    init(id: String, className: String, elementClass: String, userLabel: String?) {
        self.id = id
        self.className = className
        self.elementClass = elementClass
        self.userLabel = userLabel
    }

    func addProperty<Value: SwiftValueRepresentable>(_ name: String, value: Value, available: Availability?) {
        properties[name] = (value, available)
    }
    func hasExplicitProperty(_ name: String) -> Bool { properties[name] != nil }
    func removeProperty(_ name: String) { properties[name] = nil }
    func addMethodCall(_ method: String, arguments: [Argument]) {
        methodCalls.append((method: method, arguments: arguments))
    }

    func setInit(arguments: [(label: String, value: SwiftValueRepresentable)]) {
        precondition(self.initArguments.isEmpty)
        self.initArguments = arguments
    }

    func setConstraints(_ constraints: [Constraint]) {
        precondition(self.constraints.isEmpty)
        self.constraints = constraints
    }

    func addSubview(_ subview: ViewCodeBuilder) {
        subviews.append(subview)
    }

    func writeInit<Target>(target: inout Target, context: inout CodeGenContext, shouldWriteConstraintsActivation: Bool) throws where Target : IndentTextOutputStream {
        target.writeLine("init() {")
        try target.indented { target in
            try target.writeLine { line in
                line.write("super.init(")
                let argList = ArgumentList(arguments: initArguments.isEmpty ? [("frame", EnumCase("zero"))] : initArguments)
                try argList.writeValue(target: &line, context: context)
                line.write(")")
            }

            func writeAssignment(target: inout Target, name: String, value: SwiftValueRepresentable) throws {
                try target.writeLine { line in
                    line.write("self.\(name) = ")
                    try value.writeValue(target: &line, context: context)
                }
            }

            for (name, (value, available)) in properties.sorted(by: { $0.key > $1.key }) {
                if let available = available {
                    target.writeLine("if #available(iOS \(available.major).\(available.minor), *) {")
                    try target.indented { target in
                        try writeAssignment(target: &target, name: name, value: value)
                    }
                    target.writeLine("}")
                } else {
                    try writeAssignment(target: &target, name: name, value: value)
                }
            }

            for (method, arguments) in methodCalls {
                try target.writeLine { line in
                    line.write("self.\(method)(")
                    let argList = ArgumentList(arguments: arguments)
                    try argList.writeValue(target: &line, context: context)
                    line.write(")")
                }
            }
            let addSubviewMethod = elementClass == "UIStackView" ? "addArrangedSubview" : "addSubview"
            for subview in subviews {
                target.writeLine("self.\(addSubviewMethod)(\(context.namespace.getIdentifier(id: subview.id)))")
            }

            if shouldWriteConstraintsActivation {
                target.writeLine("activateConstraints()")
            }
        }
        target.writeLine("}")
    }

    func buildConstraintsActivation<Target: IndentTextOutputStream>(
        target: inout Target, context: inout CodeGenContext
    ) throws {
        guard shouldWriteConstraintsActivation else { return }
        target.writeLine("NSLayoutConstraint.activate([")
        try target.indented { target in
            for constraint in constraints {
                try target.writeLine { line in
                    try constraint.writeValue(target: &line, context: context, selfView: "self")
                    line.write(",")
                }
            }
        }
        target.writeIndent()
        target.write("])\n")
    }
}
