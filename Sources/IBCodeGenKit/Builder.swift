//
//  Builder.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/11.
//

import IBDecodable

protocol ViewCodeBuilder {
    func addProperty<Value: SwiftValueRepresentable>(_ name: String, value: Value)
    func addMethodCall(_ method: String, arguments: [Argument])
    func addSubview(_ subview: ViewElement)
    func setInit(arguments: [(label: String, value: SwiftValueRepresentable)])
    func setConstraints(_ constraints: [Constraint])
}

class RootViewClass {
    let className: String
    let id: String
    var subviews: [ViewElement] = []

    init(className: String, id: String) {
        self.className = className
        self.id = id
    }

    func makeSubview(id: String, className: String, elementClass: String, userLabel: String?) -> ViewElement {
        let subview = ViewElement(id: id, className: className, elementClass: elementClass, userLabel: userLabel)
        subviews.append(subview)
        return subview
    }

    func build<Target: IndentTextOutputStream>(target: inout Target, context: inout CodeGenContext) throws {
        target.writeLine("class \(className): NSObject {")
        try target.indented { target in
            for subview in subviews {
                try subview.build(target: &target, context: &context)
            }

            if subviews.contains(where: \.shouldWriteConstraintsActivation) {
                target.writeLine("func activateConstraints() {")
                try target.indented { target in
                    for subview in subviews {
                        try subview.buildConstraintsActivation(target: &target, context: &context)
                    }
                }
                target.writeLine("}")

                target.writeLine("override init() {")
                target.indented { target in
                    target.writeLine("super.init()")
                    target.writeLine("activateConstraints()")
                }
                target.writeLine("}")
            }

            let identifier = context.namespace.getIdentifier(id: id)
            target.writeLine("var contentView: UIView {")
            target.indented {
                $0.writeLine("return \(identifier)")
            }
            target.writeLine("}")
        }
        target.writeLine("}")
    }
}

struct ViewHierarchy {
    private var elementById: [String: IBElement] = [:]

    init(rootView: ViewProtocol) {
        func traverse(view: ViewProtocol) {
            if let identifiable = view as? IBIdentifiable {
                elementById[identifiable.id] = identifiable
            }
            if let viewLayoutGuide = view.viewLayoutGuide {
                elementById[viewLayoutGuide.id] = viewLayoutGuide
            }
            for subview in view.subviews ?? [] {
                traverse(view: subview.view)
            }
        }
        traverse(view: rootView)
    }

    func element(byId id: String) -> IBElement? {
        elementById[id]
    }
}

struct ViewNamespace {
    struct Hint {
        let index: Int
        var className: String
        var outlet: String?
    }
    private var hintById: [String: Hint] = [:]
    private var resolved: [String: String] = [:]
    private var suffixCounter: Int = 0

    private mutating func incrementSuffix() -> Int {
        defer { suffixCounter += 1 }
        return suffixCounter
    }

    private mutating func _makeIdentifier(from hint: Hint) -> String {
        guard let outlet = hint.outlet else {
            let hintName = toLowerCamelCase(
                fromUpperCamelCase: dropHungarianNotation(from: hint.className)
            )
            return "\(hintName)\(incrementSuffix())"
        }
        return outlet
    }

    mutating func addHint(className: String, for id: String) {
        precondition(hintById[id] == nil)
        hintById[id] = Hint(index: hintById.count, className: className, outlet: nil)
    }
    mutating func addHint(outlet: String, for id: String) {
        precondition(hintById[id] != nil)
        hintById[id]?.outlet = outlet
    }
    mutating func resolve() {
        for (id, hint) in hintById.sorted(by: { $0.value.index < $1.value.index }) {
            resolved[id] = _makeIdentifier(from: hint)
        }
    }

    func getIdentifier(id: String) -> String {
        guard let name = resolved[id] else {
            preconditionFailure("'\(id)' is not resolved yet")
        }
        return name
    }
}

typealias Argument = (label: String?, value: SwiftValueRepresentable)

struct ArgumentList: SwiftValueRepresentable {
    let arguments: [Argument]
    func writeValue<Target>(target: inout Target, context: CodeGenContext) throws where Target : IndentTextOutputStream {
        for (index, argument) in arguments.enumerated() {
            if let label = argument.label {
                target.write("\(label): ")
            }
            try argument.value.writeValue(target: &target, context: context)
            if index + 1 != arguments.endIndex {
                target.write(", ")
            }
        }
    }
}

class ViewElement: ViewCodeBuilder {
    let id: String
    let className: String
    let elementClass: String
    let userLabel: String?
    var shouldWriteConstraintsActivation: Bool { !constraints.isEmpty }
    private var properties: [String: SwiftValueRepresentable] = [:]
    private var methodCalls: [(method: String, arguments: [Argument])] = []
    private var initArguments: [Argument] = []
    private var subviews: [ViewElement] = []
    private var constraints: [Constraint] = []

    init(id: String, className: String, elementClass: String, userLabel: String?) {
        self.id = id
        self.className = className
        self.elementClass = elementClass
        self.userLabel = userLabel
    }

    func addProperty<Value: SwiftValueRepresentable>(_ name: String, value: Value) {
        properties[name] = value
    }

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

    func addSubview(_ subview: ViewElement) {
        subviews.append(subview)
    }
    func build<Target: IndentTextOutputStream>(
        target: inout Target, context: inout CodeGenContext
    ) throws {
        let fieldIdentifier = context.namespace.getIdentifier(id: id)
        target.writeLine { line in
            line.write("/// Generated from '\(id)'")
            if let userLabel = userLabel {
                line.write(": \"\(userLabel)\"")
            }
        }
        target.writeLine("lazy var \(fieldIdentifier): \(className) = {")
        try target.indented {

            try $0.writeLine { line in
                line.write("let view = \(className)(")
                let argList = ArgumentList(arguments: initArguments)
                try argList.writeValue(target: &line, context: context)
                line.write(")")
            }
            for (name, value) in properties.sorted(by: { $0.key > $1.key }) {
                try $0.writeLine { line in
                    line.write("view.\(name) = ")
                    try value.writeValue(target: &line, context: context)
                }
            }

            for (method, arguments) in methodCalls {
                try $0.writeLine { line in
                    line.write("view.\(method)(")
                    let argList = ArgumentList(arguments: arguments)
                    try argList.writeValue(target: &line, context: context)
                    line.write(")")
                }
            }
            let addSubviewMethod = elementClass == "UIStackView" ? "addArrangedSubview" : "addSubview"
            for subview in subviews {
                $0.writeLine("view.\(addSubviewMethod)(\(context.namespace.getIdentifier(id: subview.id)))")
            }
            $0.writeLine("return view")
        }
        target.writeLine("}()")
    }

    func buildConstraintsActivation<Target: IndentTextOutputStream>(
        target: inout Target, context: inout CodeGenContext
    ) throws {
        guard shouldWriteConstraintsActivation else { return }
        target.writeLine("NSLayoutConstraint.activate([")
        try target.indented { target in
            for constraint in constraints {
                try target.writeLine { line in
                    try constraint.writeValue(target: &line, context: context, selfView: id)
                    line.write(",")
                }
            }
        }
        target.writeIndent()
        target.write("])\n")
    }
}

struct ViewBinder<V> {
    let view: V
    let builder: ViewCodeBuilder
    let assumeClassDefault: Bool

    init(view: V, builder: ViewCodeBuilder, assumeClassDefault: Bool) {
        self.view = view
        self.builder = builder
        self.assumeClassDefault = assumeClassDefault
    }

    init(view: V, builder: ViewCodeBuilder) where V: ViewProtocol {
        self.view = view
        self.builder = builder
        self.assumeClassDefault = view.customClass == nil
    }

    func bind<V1: SwiftValueRepresentable, V2: SwiftValueRepresentable>(
        _ keyPath: KeyPath<V, V1>, name: String, transform: (V1) -> V2
    ) {
        builder.addProperty(name, value: transform(view[keyPath: keyPath]))
    }
    func bindIfPresent<V1: SwiftValueRepresentable, V2: SwiftValueRepresentable>(
        _ keyPath: KeyPath<V, V1?>, name: String, transform: (V1) -> V2) {
        if let value = view[keyPath: keyPath] {
            builder.addProperty(name, value: transform(value))
        }
    }
    func bindIfPresent<V1: SwiftValueRepresentable, V2: SwiftValueRepresentable>(
        _ keyPath: KeyPath<V, V1?>, classDefault: V1, name: String, transform: (V1) -> V2
    ) where V1: Equatable {
        if let value = view[keyPath: keyPath], !(assumeClassDefault && value == classDefault) {
            builder.addProperty(name, value: transform(value))
        } else if view[keyPath: keyPath] == nil && !assumeClassDefault {
            builder.addProperty(name, value: transform(classDefault))
        }
    }
    func bindIfPresent<Value: SwiftValueRepresentable>(
        _ keyPath: KeyPath<V, Value?>, name: String
    ) {
        bindIfPresent(keyPath, name: name, transform: { $0 })
    }

    func bindIfPresent<Value: SwiftValueRepresentable>(
        _ keyPath: KeyPath<V, Value?>, classDefault: Value, name: String
    ) where Value: Equatable {
        bindIfPresent(keyPath, classDefault: classDefault, name: name, transform: { $0 })
    }
    func bind<Value: SwiftValueRepresentable>(
        _ keyPath: KeyPath<V, Value?>, default: Value, name: String
    ) {
        builder.addProperty(name, value: view[keyPath: keyPath] ?? `default`)
    }
}
