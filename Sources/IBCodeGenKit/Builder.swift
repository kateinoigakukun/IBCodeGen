//
//  Builder.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/11.
//

import IBDecodable

class RootViewCodeBuilder {
    var namespace = SubviewsNamespace()
    let className: String
    let id: String
    var subviews: [SubviewCodeBuilder] = []

    init(className: String, id: String) {
        self.className = className
        self.id = id

    }

    func makeSubview(id: String, className: String) -> SubviewCodeBuilder {
        let subview = SubviewCodeBuilder(id: id, className: className)
        subviews.append(subview)
        return subview
    }

    func build<Target: IndentTextOutputStream>(target: inout Target) {
        target.writeLine("class \(className): NSObject {")
        target.indented { target in
            for subview in subviews {
                subview.build(target: &target, namespace: &namespace)
            }
            if let identifier = namespace.getIdentifier(id: id) {
                target.writeLine("var contentView: UIView {")
                target.indented {
                    $0.writeLine("return \(identifier)")
                }
                target.writeLine("}")
            }
        }
        target.writeLine("}")
    }
}

struct SubviewsNamespace {
    struct Hint {
        let className: String
        let outlet: String?
    }
    private var hintById: [String: Hint] = [:]
    private var caches: [String: String] = [:]
    private var suffixCounter: Int = 0

    private mutating func incrementSuffix() -> Int {
        defer { suffixCounter += 1 }
        return suffixCounter
    }

    private mutating func _makeIdentifier(id: String) -> String {
        guard let hint = hintById[id] else {
            return "subview\(incrementSuffix())"
        }
        guard let outlet = hint.outlet else {
            return "\(hint.className)\(incrementSuffix())"
        }
        return outlet
    }
    mutating func makeIdentifier(id: String) -> String {
        let identifier = _makeIdentifier(id: id)
        caches[id] = identifier
        return identifier
    }
    func getIdentifier(id: String) -> String? {
        caches[id]
    }
}

typealias Argument = (label: String?, value: SwiftValueRepresentable)

fileprivate func formatArguments(_ arguments: [Argument]) -> String {
    arguments.map { (label, value) in
        guard let label = label else { return value.swiftValue() }
        return "\(label): \(value.swiftValue())"
    }
    .joined(separator: ", ")
}

class SubviewCodeBuilder {
    let id: String
    let className: String
    private var properties: [(name: String, value: String)] = []
    private var methodCalls: [(method: String, arguments: [Argument])] = []
    private var initArguments: [Argument] = []
    

    init(id: String, className: String) {
        self.id = id
        self.className = className
    }

    func addProperty<Value: SwiftValueRepresentable>(_ name: String, value: Value) {
        properties.append((name: name, value: value.swiftValue()))
    }

    func addMethodCall(_ method: String, arguments: [Argument]) {
        methodCalls.append((method: method, arguments: arguments))
    }

    func setInit(arguments: [(label: String, value: SwiftValueRepresentable)]) {
        precondition(self.initArguments.isEmpty)
        self.initArguments = arguments
    }

    func build<Target: IndentTextOutputStream>(
        target: inout Target, namespace: inout SubviewsNamespace
    ) {
        let fieldIdentifier = namespace.makeIdentifier(id: id)
        target.writeLine("lazy var \(fieldIdentifier): \(className) = {")
        target.indented {

            $0.writeLine("let view = \(className)(\(formatArguments(initArguments)))")
            for (name, value) in properties {
                $0.writeLine("view.\(name) = \(value)")
            }

            for (method, arguments) in methodCalls {
                $0.writeLine("view.\(method)(\(formatArguments(arguments)))")
            }
            $0.writeLine("return view")
        }
        target.writeLine("}()")
    }
}
