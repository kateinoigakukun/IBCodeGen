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

    func makeSubview(id: String, className: String, elementClass: String) -> ViewElement {
        let subview = ViewElement(id: id, className: className, elementClass: elementClass)
        subviews.append(subview)
        return subview
    }

    func build<Target: IndentTextOutputStream>(target: inout Target, context: inout CodeGenContext) {
        target.writeLine("class \(className): NSObject {")
        target.indented { target in
            for subview in subviews {
                subview.build(target: &target, context: &context)
            }

            target.writeLine("func activateConstraints() {")
            target.indented { target in
                for subview in subviews {
                    subview.buildConstraintsActivation(target: &target, context: &context)
                }
            }
            target.writeLine("}")

            target.writeLine("override init() {")
            target.indented { target in
                target.writeLine("super.init()")
                target.writeLine("activateConstraints()")
            }
            target.writeLine("}")

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
        hintById[id] = Hint(className: className, outlet: nil)
    }
    mutating func addHint(outlet: String, for id: String) {
        precondition(hintById[id] != nil)
        hintById[id]?.outlet = outlet
    }
    mutating func resolve() {
        for (id, hint) in hintById {
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
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        for (index, argument) in arguments.enumerated() {
            if let label = argument.label {
                target.write("\(label): ")
            }
            argument.value.writeValue(target: &target, context: context)
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
    private var properties: [(name: String, value: SwiftValueRepresentable)] = []
    private var methodCalls: [(method: String, arguments: [Argument])] = []
    private var initArguments: [Argument] = []
    private var subviews: [ViewElement] = []
    private var constraints: [Constraint] = []

    init(id: String, className: String, elementClass: String) {
        self.id = id
        self.className = className
        self.elementClass = elementClass
    }

    func addProperty<Value: SwiftValueRepresentable>(_ name: String, value: Value) {
        properties.append((name: name, value: value))
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
    ) {
        let fieldIdentifier = context.namespace.getIdentifier(id: id)
        target.writeLine("lazy var \(fieldIdentifier): \(className) = {")
        target.indented {

            $0.writeLine { line in
                line.write("let view = \(className)(")
                let argList = ArgumentList(arguments: initArguments)
                argList.writeValue(target: &line, context: context)
                line.write(")")
            }
            for (name, value) in properties {
                $0.writeLine { line in
                    line.write("view.\(name) = ")
                    value.writeValue(target: &line, context: context)
                }
            }

            for (method, arguments) in methodCalls {
                $0.writeLine { line in
                    line.write("view.\(method)(")
                    let argList = ArgumentList(arguments: arguments)
                    argList.writeValue(target: &line, context: context)
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
    ) {
        target.writeLine("NSLayoutConstraint.activate([")
        target.indented { target in
            for constraint in constraints {
                target.writeLine { line in
                    constraint.writeValue(target: &line, context: context, selfView: id)
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
    func bindIfPresent<Value: SwiftValueRepresentable>(
        _ keyPath: KeyPath<V, Value?>, name: String
    ) {
        bindIfPresent(keyPath, name: name, transform: { $0 })
    }

    func bind<Value: SwiftValueRepresentable>(
        _ keyPath: KeyPath<V, Value?>, default: Value, name: String
    ) {
        builder.addProperty(name, value: view[keyPath: keyPath] ?? `default`)
    }
}
