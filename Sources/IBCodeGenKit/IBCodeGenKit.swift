import IBDecodable

public class IBCodeGenerator {
    public init() {
    }

    public struct GeneratedResult {
        public var classNames: [String?]
    }
    public enum ClassTemplate {
        case owner, customView
    }
    public struct Options {
        public var excludedRootViews: [String] = []
        public var classTemplate: ClassTemplate

        public init(excludedRootViews: [String] = [], classTemplate: ClassTemplate = .owner) {
            self.excludedRootViews = excludedRootViews
            self.classTemplate = classTemplate
        }
    }

    public func generate<Target: TextOutputStream>(
        from xmlContent: String, fileBaseName: String, options: Options = Options(),
        target: inout Target
    ) throws -> GeneratedResult {
        var output = GenericIndentTextOutputStream(downstream: target)
        return try generate(from: xmlContent, fileBaseName: fileBaseName, options: options, target: &output)
    }

    func generate<Target: IndentTextOutputStream>(
        from xmlContent: String, fileBaseName: String, options: Options, target: inout Target
    ) throws -> GeneratedResult {
        let xibFile = try XibFile(xml: xmlContent)
        guard let views = xibFile.document.views else { return GeneratedResult(classNames: []) }
        target.writeLine("import UIKit")
        var namespace = ViewClassNamespace(fileName: fileBaseName, viewCount: views.count)

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

            
            func makeClassBuilder(template: ClassTemplate) -> RootClassBuilder {
                if element is TableViewCell {
                    return TableViewCellTemplate(
                        baseCustomViewClassName: namespace.makeIdentifier(forIndex: index),
                        id: element.id
                    )
                }
                switch template {
                case .owner:
                    return OwnerClassClass(
                        baseClassName: namespace.makeIdentifier(forIndex: index),
                        id: element.id
                    )
                case .customView:
                    return CustomViewClassTemplate(
                        baseCustomViewClassName: namespace.makeIdentifier(forIndex: index),
                        id: element.id
                    )
                }
            }

            let builder = makeClassBuilder(template: options.classTemplate)
            _ = try codegen(from: view, rootView: builder, context: &context)
            target.writeLine("\n\n")
            context.namespace.resolve()
            try builder.build(target: &target, context: &context)
            result.classNames.append(builder.className)
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
