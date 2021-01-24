//
//  UILabel.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//


import IBDecodable

extension Label: CodeGenTargetView {
    func validate() throws {
        guard minimumFontSize == nil else {
            throw Error.minimumFontSizeIsNotSupported(self)
        }
        guard adjustsLetterSpacingToFitWidth == nil else {
            throw Error.adjustsLetterSpacingToFitWidthIsNotSupported(self)
        }
    }
    func codegen(builder: ViewCodeBuilder, rootView: RootViewClass) throws {
        let b = ViewBinder(view: self, builder: builder)
        b.bindIfPresent(\.text, name: "text")
        b.bindIfPresent(\.attributedText, name: "attributedText")

        b.bindIfPresent(\.textAlignment, classDefault: "center",
                        name: "textAlignment", transform: EnumCase.init)
        b.bind(\.baselineAdjustment, default: "alignCenters",
               name: "baselineAdjustment", transform: EnumCase.init)
        b.bind(\.adjustsFontSizeToFit, default: true, name: "adjustsFontSizeToFitWidth")

        b.bindIfPresent(\.adjustsLetterSpacingToFitWidth, name: "adjustsLetterSpacingToFitWidth")
        b.bindIfPresent(\.adjustsFontForContentSizeCategory, name: "adjustsFontForContentSizeCategory")
        b.bindIfPresent(\.minimumScaleFactor, name: "minimumScaleFactor")
        b.bindIfPresent(\.fontDescription, name: "font")
        b.bindIfPresent(\.numberOfLines, name: "numberOfLines")
        b.bindIfPresent(\.textColor, name: "textColor")
        b.bindIfPresent(\.highlightedColor, name: "highlightedTextColor")
        b.bindIfPresent(\.shadowColor, name: "shadowColor")
        b.bindIfPresent(\.shadowOffset, name: "shadowOffset")
        b.bindIfPresent(\.lineBreakMode, name: "lineBreakMode", transform: LineBreakMode.init)

        // isHighlighted is always false even it's true in IB
        // b.bindIfPresent(\.highlighted, name: "isHighlighted")
    }
}
