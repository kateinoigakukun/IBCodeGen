//
//  UIActivityindicatorView.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable

extension ActivityindicatorView: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewClass) throws {
        builder.addProperty("isHidden", value: false)
        if let style = style {
            builder.setInit(arguments: [(label: "style", value: EnumCase(style))])
        }
    }
}
