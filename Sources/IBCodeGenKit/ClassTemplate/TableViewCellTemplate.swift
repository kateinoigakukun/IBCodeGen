//
//  TableViewCellTemplate.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/28.
//

import IBDecodable

final class TableViewCellTemplate: RootClassBuilder {
    let className: String
    let id: String
    private var cellElement: TableViewCellElement?
    private var contentElement: TableViewCellContentElement?
    private var subviews: [ViewElement] = []

    init(baseCustomViewClassName: String, id: String) {
        self.className = baseCustomViewClassName + "_XibSkeleton"
        self.id = id
    }

    func makeSubview(id: String, className: String, elementClass: String, userLabel: String?) -> ViewCodeBuilder {
        if self.id == id {
            let cellElement = TableViewCellElement(
                id: id, className: className,
                elementClass: elementClass, userLabel: userLabel
            )
            self.cellElement = cellElement
            return cellElement
        }

        if elementClass == "UITableViewContentView" {
            let contentElement = TableViewCellContentElement(
                id: id, className: className,
                elementClass: elementClass, userLabel: userLabel
            )
            self.contentElement = contentElement
            return contentElement
        }

        let subview = ViewElement(id: id, className: className, elementClass: elementClass, userLabel: userLabel)
        subviews.append(subview)
        return subview
    }

    func build<Target>(target: inout Target, context: inout CodeGenContext) throws where Target : IndentTextOutputStream {
        guard let cellElement = cellElement, let contentElement = contentElement else {
            preconditionFailure()
        }

        target.writeLine { line in
            line.write("/// Generated from '\(id)'")
            if let userLabel = cellElement.userLabel {
                line.write(": \"\(userLabel)\"")
            }
        }

        target.writeLine("class \(className): \(cellElement.elementClass) {")

        let shouldWriteConstraintsActivation = subviews.contains(where: \.shouldWriteConstraintsActivation) ||
            contentElement.shouldWriteConstraintsActivation
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
                    try contentElement.buildConstraintsActivation(target: &target, context: &context)
                }
                target.writeLine("}")
            }

            try writeInit(target: &target, context: &context, shouldWriteConstraintsActivation: shouldWriteConstraintsActivation)
        }

        target.writeLine("}")
    }

    private func writeInit<Target>(
        target: inout Target, context: inout CodeGenContext,
        shouldWriteConstraintsActivation: Bool
    ) throws where Target : IndentTextOutputStream {
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

        target.writeLine("override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {")
        try target.indented { target in
            target.writeLine("super.init(style: style, reuseIdentifier: reuseIdentifier)")
            try cellElement?.writeInitBody(target: &target, context: &context)
            target.writeLine("")
            try contentElement?.writeInitBody(
                target: &target, context: &context,
                shouldWriteConstraintsActivation: shouldWriteConstraintsActivation
            )
        }
        target.writeLine("}")
    }
}

fileprivate final class TableViewCellElement: ViewCodeBuilder {
    let id: String
    let className: String
    let elementClass: String
    let userLabel: String?
    private var properties: [String: (SwiftValueRepresentable, Availability?)] = [:]
    private var methodCalls: [(method: String, arguments: [Argument])] = []
    private var initArguments: [Argument] = []

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
        fatalError("UITableViewCell shouldn't have constraints")
    }

    func addSubview(_ subview: ViewCodeBuilder) {
        // nop
    }

    func writeInitBody<Target>(
        target: inout Target, context: inout CodeGenContext
    ) throws where Target : IndentTextOutputStream {
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
    }
}

fileprivate final class TableViewCellContentElement: ViewCodeBuilder {
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

    func writeInitBody<Target>(
        target: inout Target, context: inout CodeGenContext,
        shouldWriteConstraintsActivation: Bool
    ) throws where Target : IndentTextOutputStream {
        func writeAssignment(target: inout Target, name: String, value: SwiftValueRepresentable) throws {
            try target.writeLine { line in
                line.write("self.contentView.\(name) = ")
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

        for subview in subviews {
            target.writeLine("self.contentView.addSubview(\(context.namespace.getIdentifier(id: subview.id)))")
        }

        if shouldWriteConstraintsActivation {
            target.writeLine("activateConstraints()")
        }
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
