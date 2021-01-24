import Foundation
import IBDecodable

public class IBCodeGenerator {
    public init() {
    }

    public struct GeneratedResult {
        public var classNames: [String?]
    }
    public struct Options {
        public var excludedRootViews: [String] = []

        public init(excludedRootViews: [String] = []) {
            self.excludedRootViews = excludedRootViews
        }
    }

    public func generate<Target: TextOutputStream>(
        from url: URL, options: Options = Options(),
        target: inout Target
    ) throws -> GeneratedResult {
        var output = GenericIndentTextOutputStream(downstream: target)
        return try generate(from: url, options: options, target: &output)
    }

    func generate<Target: IndentTextOutputStream>(
        from url: URL, options: Options, target: inout Target
    ) throws -> GeneratedResult {
        let xibFile = try XibFile(url: url)
        guard let views = xibFile.document.views else { return GeneratedResult(classNames: []) }
        target.writeLine("import UIKit")
        var namespace = ViewClassNamespace(
            fileName: url.deletingPathExtension().lastPathComponent, viewCount: views.count)

        for (index, view) in views.enumerated() {
            guard let customClass = view.view.customClass else { continue }
            namespace.setCustomClassName(forIndex: index, name: customClass)
        }

        var result = GeneratedResult(classNames: [])
        for (index, view) in views.enumerated() {
            guard let element = view.view as? IBIdentifiable,
                  !options.excludedRootViews.contains(element.id) else {
                result.classNames.append(nil)
                continue
            }
            var context = CodeGenContext(
                deploymentTarget: Version(major: 12, minor: 0, patch: 0),
                document: xibFile.document, namespace: ViewNamespace(),
                hierarchy: ViewHierarchy(rootView: view.view)
            )
            let className = namespace.makeIdentifier(forIndex: index) + "Owner"
            let builder = RootViewClass(
                className: className,
                id: element.id
            )
            _ = try codegen(from: view, rootView: builder, context: &context)
            target.writeLine("\n\n")
            context.namespace.resolve()
            builder.build(target: &target, context: &context)
            result.classNames.append(className)
        }
        return result
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
