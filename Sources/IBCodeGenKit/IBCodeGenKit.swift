import Foundation
import IBDecodable

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
        target.writeLine("import UIKit")
        var namespace = ViewClassNamespace(
            fileName: url.deletingPathExtension().lastPathComponent, viewCount: views.count)

        for (index, view) in views.enumerated() {
            guard let customClass = view.view.customClass else { continue }
            namespace.setCustomClassName(forIndex: index, name: customClass)
        }

        for (index, view) in views.enumerated() {
            guard let identifiable = view.view as? IBIdentifiable else { continue }
            var context = CodeGenContext(
                deploymentTarget: Version(major: 12, minor: 0, patch: 0),
                document: xibFile.document, namespace: SubviewsNamespace()
            )
            let builder = RootViewCodeBuilder(
                className: namespace.makeIdentifier(forIndex: index) + "Owner",
                id: identifiable.id
            )
            _ = try codegen(from: view, rootView: builder, context: &context)
            target.writeLine("\n\n")
            context.namespace.resolve()
            builder.build(target: &target, context: &context)
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
