//
//  UILabel.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//


import IBDecodable

extension Label: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewCodeBuilder) throws {
        let b = ViewBinder(view: self, builder: builder)
        b.bindIfPresent(\.text, name: "text")
        b.bindIfPresent(\.textAlignment, name: "textAlignment", transform: EnumCase.init)
        b.bindIfPresent(\.baselineAdjustment, name: "baselineAdjustment", transform: EnumCase.init)
        b.bindIfPresent(\.adjustsFontSizeToFit, name: "adjustsFontSizeToFitWidth")
        b.bindIfPresent(\.fontDescription, name: "font")
        b.bindIfPresent(\.lineBreakMode, name: "lineBreakMode", transform: LineBreakMode.init)
    }
}
