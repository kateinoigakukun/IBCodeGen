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
        builder.addProperty("autoresizingMask", value: autoresizingMask)
    }

    if let rect = view.rect {
        builder.addProperty("frame", value: rect)
    }

    switch view {
    case let button as Button:
        try codegen(for: button, builder: builder, rootView: rootView)
    default:
        break
    }
}

func codegen(
    for button: Button,
    builder: SubviewCodeBuilder,
    rootView: RootViewCodeBuilder
) throws {
    if let buttonType = button.buttonType {
        builder.setInit(arguments: [(label: "type", value: EnumCase(buttonType))])
    }
    for state in (button.state ?? []) {
        guard let key = state.key else { continue }
        if let title = state.title {
            builder.addMethodCall("setTitle", arguments: [
                (label: nil, value: title), (label: "for", value: EnumCase(key))
            ])
        }
        if let attributedString = state.attributedString {
            builder.addMethodCall("setAttributedTitle", arguments: [
                (label: nil, value: attributedString), (label: "for", value: EnumCase(key))
            ])
        }
    }
}
