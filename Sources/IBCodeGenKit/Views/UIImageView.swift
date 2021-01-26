//
//  UIImageView.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/19.
//

import IBDecodable

extension ImageView: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootClassBuilder) throws {
        let b = ViewBinder(view: self, builder: builder)
        b.bindIfPresent(\.image, name: "image", transform: {
            Image(name: $0, catalog: catalog, symbolConfiguration: .imageViewSymbolImage)
        })
        b.bindIfPresent(\.highlightedImage, name: "highlightedImage", transform: {
            Image(name: $0, catalog: catalog, symbolConfiguration: .imageViewSymbolImage)
        })
        b.bindIfPresent(\.imageReference, name: "image")
        b.bindIfPresent(\.preferredSymbolConfiguration,
                        name: "preferredSymbolConfiguration", available: .iOS13)
        b.bindIfPresent(\.adjustsImageSizeForAccessibilityContentSizeCategory,
                        name: "adjustsImageSizeForAccessibilityContentSizeCategory")
    }
}
