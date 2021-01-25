//
//  UIButton.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable


extension Button: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewClass) throws {
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
            if let attributedString = state.attributedString, !attributedString.isNilValue {
                builder.addMethodCall("setAttributedTitle", arguments: [
                    (label: nil, value: attributedString), (label: "for", value: EnumCase(key))
                ])
            }
            if let image = state.image {
                builder.addMethodCall("setImage", arguments: [
                    (label: nil, value: Image(name: image, catalog: state.catalog, symbolConfiguration: .buttonSymbolImage)),
                    (label: "for", value: EnumCase(key))
                ])
            }
            if let titleColor = state.titleColor {
                builder.addMethodCall("setTitleColor", arguments: [
                    (label: nil, value: titleColor),
                    (label: "for", value: EnumCase(key))
                ])
            } else if buttonType == nil {
                // Default title color for custom button
                builder.addMethodCall("setTitleColor", arguments: [
                    (label: nil, value: RawValueString("UIColor.white")),
                    (label: "for", value: EnumCase(key))
                ])
            }
            if let titleShadowColor = state.titleShadowColor {
                builder.addMethodCall("setTitleShadowColor", arguments: [
                    (label: nil, value: titleShadowColor),
                    (label: "for", value: EnumCase(key))
                ])
            }
        }

        b.bindIfPresent(\.opaque, classDefault: false, name: "isOpaque")
        b.bindIfPresent(\.contentHorizontalAlignment, classDefault: "center",
                        name: "contentHorizontalAlignment", transform: EnumCase.init)
        b.bindIfPresent(\.contentVerticalAlignment, classDefault: "center",
                        name: "contentVerticalAlignment", transform: EnumCase.init)
        b.bindIfPresent(\.isEnabled, classDefault: true, name: "isEnabled")
        b.bindIfPresent(\.showsTouchWhenHighlighted, classDefault: false, name: "showsTouchWhenHighlighted")
        b.bindIfPresent(\.contentEdgeInsets, name: "contentEdgeInsets")
        b.bindIfPresent(\.titleEdgeInsets, name: "titleEdgeInsets")
        b.bindIfPresent(\.imageEdgeInsets, name: "imageEdgeInsets")

        // Default configuration for custom buttons
        if buttonType == nil {
            // Set default configuration for inner UILabel only when there are state titles
            if let state = state, !state.isEmpty {
                b.bind(\.fontDescription, default: FontDescription.default, name: "titleLabel?.font")
                b.bindIfPresent(\.lineBreakMode, name: "titleLabel?.lineBreakMode", transform: LineBreakMode.init)
            } else {
                // when no state title
                builder.addProperty("titleLabel?.font", value: FontDescription.default)
                builder.addMethodCall("setTitleColor", arguments: [
                    (label: nil, value: RawValueString("UIColor.white")),
                    (label: "for", value: EnumCase("normal"))
                ])
            }
        } else {
            // Default configuration for system buttons
            b.bindIfPresent(\.fontDescription, name: "titleLabel?.font")
            // Set default configuration for no title
            if state?.isEmpty ?? true {
                builder.addMethodCall("setTitleColor", arguments: [
                    (label: nil, value: EnumCase("systemBlue")),
                    (label: "for", value: EnumCase("normal")),
                ])
            }
        }
    }
}
