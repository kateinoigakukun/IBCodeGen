import Foundation
import IBDecodable

public class IBCodeGenerator {
    let context: CodeGenContext
    public init() {
        context = CodeGenContext(deploymentTarget: Version(major: 12, minor: 0, patch: 0))
    }

    func generate<Target: TextOutputStream>(from url: URL, target: inout Target) throws {
        var output = GenericIndentTextOutputStream(downstream: target)
        try generate(from: url, target: &output)
    }

    func generate<Target: IndentTextOutputStream>(from url: URL, target: inout Target) throws {
        let xibFile = try XibFile(url: url)
        guard let views = xibFile.document.views else { return }
        target.writeLine("import UIKit")
        var namespace = ViewClassNamespace(
            fileName: url.deletingPathExtension().lastPathComponent, viewCount: views.count)

        for (index, view) in views.enumerated() {
            guard let customClass = view.view.customClass else { continue }
            namespace.setCustomClassName(forIndex: index, name: customClass)
        }

        for (index, view) in views.enumerated() {
            guard let identifiable = view.view as? IBIdentifiable else { continue }
            let builder = RootViewCodeBuilder(
                className: namespace.makeIdentifier(forIndex: index), id: identifiable.id, context: context)
            _ = try codegen(from: view, rootView: builder)
            target.writeLine("\n\n")
            builder.namespace.resolve()
            builder.build(target: &target)
        }
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
            if viewCount == 1 { return fileName } else { return "\(fileName)_\(index)" }
        }
        return className
    }
}
