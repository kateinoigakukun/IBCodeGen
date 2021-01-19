//
//  UIButton.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable


extension Button: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewCodeBuilder) throws {
        let b = ViewBinder(view: self, builder: builder)
        if let buttonType = buttonType {
            builder.setInit(arguments: [(label: "type", value: EnumCase(buttonType))])
            builder.addProperty("adjustsImageWhenDisabled", value: true)
            builder.addProperty("adjustsImageWhenHighlighted", value: true)
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
            if let image = state.image {
                builder.addMethodCall("setImage", arguments: [
                    (label: nil, value: RawValueString("UIImage(named: \"\(image)\", in: Bundle(for: Self.self), compatibleWith: nil)")),
                    (label: "for", value: EnumCase(key))
                ])
            }
        }

        b.bindIfPresent(\.contentHorizontalAlignment, name: "contentHorizontalAlignment") {
            EnumCase($0)
        }
        b.bindIfPresent(\.contentVerticalAlignment, name: "contentVerticalAlignment") {
            EnumCase($0)
        }
        b.bindIfPresent(\.isEnabled, name: "isEnabled")
        if let state = state, !state.isEmpty, buttonType == nil {
            builder.addProperty("titleLabel?.font", value: FontDescription.default)
            b.bindIfPresent(\.lineBreakMode, name: "titleLabel?.lineBreakMode", transform: LineBreakMode.init)
        }
        b.bindIfPresent(\.fontDescription, name: "titleLabel?.font")
    }
}
