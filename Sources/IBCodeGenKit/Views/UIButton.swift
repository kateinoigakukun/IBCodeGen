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

        // Default configuration for system buttons
        if buttonType == nil {
            // Set default configuration for no title
            if state?.isEmpty ?? true {
                builder.addMethodCall("setTitleColor", arguments: [
                    (label: nil, value: EnumCase("systemBlue")),
                    (label: "for", value: EnumCase("normal")),
                ])
            }
            // Set default configuration for inner UILabel only when there are state titles
            if let state = state, !state.isEmpty {
                b.bind(\.fontDescription, default: FontDescription.default, name: "titleLabel?.font")
                b.bindIfPresent(\.lineBreakMode, name: "titleLabel?.lineBreakMode", transform: LineBreakMode.init)
            }
        }
    }
}
