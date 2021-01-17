//
//  UIButton.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable


extension Button: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewCodeBuilder) throws {
        if let buttonType = buttonType {
            builder.setInit(arguments: [(label: "type", value: EnumCase(buttonType))])
        }
        for state in (state ?? []) {
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
}
