//
//  CodeGen.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/11.
//

import IBDecodable

enum Error: Swift.Error {
    case unsupportedView(ViewProtocol)
    case invalidTableViewCellStyle(String)
    case sizeClassIsNotSupported(ViewProtocol)
    case catalogColorIsNotSupported(Color)
    case minimumFontSizeIsNotSupported(ViewProtocol)
    case adjustsLetterSpacingToFitWidthIsNotSupported(ViewProtocol)
    case opaqueBarIsNotSupported(ViewProtocol)
    case modalSheetIsNotSupported(ViewProtocol)
}

protocol CodeGenTargetView {
    func validate() throws
    func codegen(
        builder: ViewCodeBuilder,
        rootView: RootClassBuilder
    ) throws
}

extension CodeGenTargetView {
    func validate() throws {}
}


class CodeGenContext {
    var deploymentTarget: Version
    var document: InterfaceBuilderDocument
    var namespace: ViewNamespace
    let hierarchy: ViewHierarchy

    public init(deploymentTarget: Version, document: InterfaceBuilderDocument, namespace: ViewNamespace, hierarchy: ViewHierarchy) {
        self.deploymentTarget = deploymentTarget
        self.document = document
        self.namespace = namespace
        self.hierarchy = hierarchy
    }

    var isSupportingDarkMode: Bool {
        Version(major: 13, minor: 0, patch: 0) <= deploymentTarget
    }

    func systemColor(name: String) -> Color? {
        guard let resources = document.resources else {
            return nil
        }
        let systemColors = resources.lazy.compactMap { resource -> SystemColor? in
            guard let systemColor = resource.resource as? SystemColor else {
                return nil
            }
            return systemColor
        }
        return systemColors.first(where: { $0.name == name })?.color
    }
}

func codegen(from anyView: AnyView, rootView: RootClassBuilder,
             context: inout CodeGenContext) throws -> ViewCodeBuilder {
    let className = anyView.view.customClass ?? anyView.view.elementClass
    guard let view = anyView.view as? IBIdentifiable & ViewProtocol else {
        throw Error.unsupportedView(anyView.view)
    }
    context.namespace.addHint(className: className, for: view.id)
    let builder = rootView.makeSubview(
        id: view.id, className: className,
        elementClass: anyView.view.elementClass,
        userLabel: anyView.view.userLabel
    )

    try anyView.validate()
    try anyView.codegen(builder: builder, rootView: rootView)

    if let targetView = view as? CodeGenTargetView {
        try targetView.validate()
        try targetView.codegen(builder: builder, rootView: rootView)
    }

    for subview in anyView.view.subviews ?? [] {
        let subviewBuilder = try codegen(from: subview, rootView: rootView, context: &context)
        builder.addSubview(subviewBuilder)
    }
    return builder
}
