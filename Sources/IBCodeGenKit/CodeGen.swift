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
