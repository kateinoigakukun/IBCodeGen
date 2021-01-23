//
//  UIImageView.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/19.
//

import IBDecodable

extension ImageView: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewClass) throws {
        if let image = image {
            builder.addProperty("image", value: RawValueString("UIImage(named: \"\(image)\", in: Bundle(for: Self.self), compatibleWith: nil)"))
        }
    }
}
