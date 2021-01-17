//
//  UIView.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable

extension AnyView: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewCodeBuilder) throws {
        if let autoresizingMask = view.autoresizingMask {
            builder.addProperty("autoresizingMask", value: autoresizingMask)
        }

        if let rect = view.rect {
            builder.addProperty("frame", value: rect)
        }
        if let backgroundColor = view.backgroundColor {
            builder.addProperty("backgroundColor", value: backgroundColor)
        }
    }
}
