import IBDecodable
import Foundation

public class IBCodeGenerator {
    public init() {
        
    }

    func generate<Target: TextOutputStream>(from url: URL, target: inout Target) throws {
        var output = GenericIndentTextOutputStream(downstream: target)
        try generate(from: url, target: &output)
    }

    func generate<Target: IndentTextOutputStream>(from url: URL, target: inout Target) throws {
        let xibFile = try XibFile(url: url)
        guard let views = xibFile.document.views else { return }
        target.writeLine("""
        import UIKit

        """)
        var namespace = ViewClassNamespace(
            fileName: url.deletingPathExtension().lastPathComponent, viewCount: views.count)

        for (index, view) in views.enumerated() {
            guard let customClass = view.view.customClass else { continue }
            namespace.setCustomClassName(forIndex: index, name: customClass)
        }

        for (index, view) in views.enumerated() {
            guard let identifiable = view.view as? IBIdentifiable else { continue }
            let builder = RootViewCodeBuilder(className: namespace.makeIdentifier(forIndex: index), id: identifiable.id)
            try codegen(from: view, rootView: builder)
            builder.build(target: &target)
            target.writeLine("\n\n")
        }
    }
}

protocol IndentTextOutputStream {
    mutating func writeLine(_ line: String)
    mutating func indented(_ body: (inout Self) -> Void)
}

struct GenericIndentTextOutputStream<Downstream: TextOutputStream>: IndentTextOutputStream {
    private var indentLevel: Int = 0
    private var downstream: Downstream
    let indent: Int
    init(downstream: Downstream, indent: Int = 4) {
        self.downstream = downstream
        self.indent = indent
    }

    mutating func writeLine(_ line: String) {
        downstream.write(String(repeating: " ", count: indentLevel * indent) + line + "\n")
    }
    mutating func indented(_ body: (inout GenericIndentTextOutputStream) -> Void) {
        indentLevel += 1
        body(&self)
        indentLevel -= 1
    }
}

struct ViewClassNamespace {
    let fileName: String
    let viewCount: Int
    var classNames: [Int: String] = [:]

    mutating func setCustomClassName(forIndex index: Int, name: String) {
        classNames[index] = name
    }

    func makeIdentifier(forIndex index: Int) -> String {
        guard let className = classNames[index] else {
            if viewCount == 1 { return fileName }
            else { return "\(fileName)_\(index)" }
        }
        return className
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

class SubviewCodeBuilder {
    let id: String
    let className: String
    var properties: [(name: String, value: String)] = []
    init(id: String, className: String) {
        self.id = id
        self.className = className
    }

    func setProperty<Value: SwiftValueRepresentable>(_ name: String, value: Value) {
        properties.append((name: name, value: value.swiftValue()))
    }
    func build<Target: IndentTextOutputStream>(target: inout Target, namespace: inout SubviewsNamespace) {
        let fieldIdentifier = namespace.makeIdentifier(id: id)
        target.writeLine("lazy var \(fieldIdentifier): \(className) = {")
        target.indented {
            $0.writeLine("let view = \(className)()")
            for (name, value) in properties {
                $0.writeLine("view.\(name) = \(value)")
            }
            $0.writeLine("return view")
        }
        target.writeLine("}()")
    }
}

enum Error: Swift.Error {
    case unsupportedView(ViewProtocol)
}

func codegen(from anyView: AnyView, rootView: RootViewCodeBuilder) throws {
    let className = anyView.view.customClass ?? anyView.view.elementClass
    guard let view = anyView.view as? IBIdentifiable & ViewProtocol else {
        throw Error.unsupportedView(anyView.view)
    }
    let builder = rootView.makeSubview(id: view.id, className: className)

    if let autoresizingMask = view.autoresizingMask {
        builder.setProperty("autoresizingMask", value: autoresizingMask)
    }

    if let rect = view.rect {
        builder.setProperty("frame", value: rect)
    }
}

internal protocol SwiftValueRepresentable {
    func swiftValue() -> String
}

extension AutoresizingMask: SwiftValueRepresentable {
    func swiftValue() -> String {
        var mask: [String] = []
        if widthSizable {
            mask.append("flexibleWidth")
        }
        if heightSizable {
            mask.append("flexibleHeight")
        }
        if flexibleMinX {
            mask.append("flexibleLeftMargin")
        }
        if flexibleMaxX {
            mask.append("flexibleRightMargin")
        }
        if flexibleMinY {
            mask.append("flexibleTopMargin")
        }
        if flexibleMaxY {
            mask.append("flexibleBottomMargin")
        }
        return "[\(mask.map { ".\($0)" }.joined(separator: ", "))]"
    }
}

extension Rect: SwiftValueRepresentable {
    func swiftValue() -> String {
        return "CGRect(x: \(x), y: \(y), width: \(width), height: \(height))"
    }
}
