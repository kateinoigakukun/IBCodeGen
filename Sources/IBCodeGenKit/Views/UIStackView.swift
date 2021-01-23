//
//  UIStackView.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable

extension StackView: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewClass) throws {
        let b = ViewBinder(view: self, builder: builder)
        b.bind(\.axis, name: "axis", transform: EnumCase.init)
        b.bindIfPresent(\.distribution, name: "distribution", transform: EnumCase.init)
        b.bindIfPresent(\.alignment, name: "alignment", transform: EnumCase.init)
        b.bindIfPresent(\.spacing, name: "spacing")
    }
}
