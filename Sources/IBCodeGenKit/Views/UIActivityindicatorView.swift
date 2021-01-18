//
//  UIActivityindicatorView.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable

extension ActivityindicatorView: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewCodeBuilder) throws {
        builder.addProperty("isHidden", value: false)
    }
}
