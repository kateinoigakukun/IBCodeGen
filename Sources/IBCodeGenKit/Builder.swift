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
    func addSubview(_ subview: SubviewCodeBuilder)
    func setInit(arguments: [(label: String, value: SwiftValueRepresentable)])
}

class RootViewCodeBuilder {
    var namespace = SubviewsNamespace()
    let className: String
    let id: String
    let context: CodeGenContext
    var subviews: [SubviewCodeBuilder] = []

    init(className: String, id: String, context: CodeGenContext) {
        self.className = className
        self.id = id
        self.context = context
    }

    func makeSubview(id: String, className: String) -> SubviewCodeBuilder {
        let subview = SubviewCodeBuilder(id: id, className: className, context: context)
        subviews.append(subview)
        return subview
    }

    func build<Target: IndentTextOutputStream>(target: inout Target) {
        target.writeLine("class \(className): NSObject {")
        target.indented { target in
            for subview in subviews {
                subview.build(target: &target, namespace: &namespace)
            }
            let identifier = namespace.getIdentifier(id: id)
            target.writeLine("var contentView: UIView {")
            target.indented {
                $0.writeLine("return \(identifier)")
            }
            target.writeLine("}")
        }
        target.writeLine("}")
    }
}

struct SubviewsNamespace {
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

class SubviewCodeBuilder: ViewCodeBuilder {
    let id: String
    let className: String
    let context: CodeGenContext
    private var properties: [(name: String, value: SwiftValueRepresentable)] = []
    private var methodCalls: [(method: String, arguments: [Argument])] = []
    private var initArguments: [Argument] = []
    private var subviews: [SubviewCodeBuilder] = []

    init(id: String, className: String, context: CodeGenContext) {
        self.id = id
        self.className = className
        self.context = context
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

    func addSubview(_ subview: SubviewCodeBuilder) {
        subviews.append(subview)
    }
    func build<Target: IndentTextOutputStream>(
        target: inout Target, namespace: inout SubviewsNamespace
    ) {
        let fieldIdentifier = namespace.getIdentifier(id: id)
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
            for subview in subviews {
                $0.writeLine("view.addSubview(\(namespace.getIdentifier(id: subview.id)))")
            }
            $0.writeLine("return view")
        }
        target.writeLine("}()")
    }
}
