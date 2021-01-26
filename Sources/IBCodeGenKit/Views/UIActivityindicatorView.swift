//
//  UIActivityindicatorView.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable

extension ActivityindicatorView: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootClassBuilder) throws {
        let b = ViewBinder(view: self, builder: builder)
        b.bind(\.isHidden, default: false, name: "isHidden")
        if let style = style {
            builder.setInit(arguments: [(label: "style", value: EnumCase(style))])
        }
    }
}
