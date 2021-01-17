//
//  CodeGen.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/11.
//

import IBDecodable

enum Error: Swift.Error {
    case unsupportedView(ViewProtocol)
}

protocol CodeGenTargetView {
    func codegen(
        builder: ViewCodeBuilder,
        rootView: RootViewCodeBuilder
    ) throws
}


struct CodeGenContext {
    var deploymentTarget: Version

    var isSupportingDarkMode: Bool {
        Version(major: 13, minor: 0, patch: 0) <= deploymentTarget
    }
}

func codegen(from anyView: AnyView, rootView: RootViewCodeBuilder) throws -> SubviewCodeBuilder {
    let className = anyView.view.customClass ?? anyView.view.elementClass
    guard let view = anyView.view as? IBIdentifiable & ViewProtocol else {
        throw Error.unsupportedView(anyView.view)
    }
    rootView.namespace.addHint(className: className, for: view.id)
    let builder = rootView.makeSubview(id: view.id, className: className)

    try anyView.codegen(builder: builder, rootView: rootView)

    if let targetView = view as? CodeGenTargetView {
        try targetView.codegen(builder: builder, rootView: rootView)
    }

    for subview in anyView.view.subviews ?? [] {
        let subviewBuilder = try codegen(from: subview, rootView: rootView)
        builder.addSubview(subviewBuilder)
    }
    return builder
}
