//
//  UIView.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable

extension AnyView: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewCodeBuilder) throws {
        let b = ViewBinder(view: self.view, builder: builder)
        builder.addProperty("autoresizingMask", value: view.autoresizingMask ?? .default)
        b.bindIfPresent(\.rect, name: "frame")
        builder.addProperty("isUserInteractionEnabled", value: true)
        b.bindIfPresent(\.userInteractionEnabled, name: "isUserInteractionEnabled")
        b.bindIfPresent(\.isHidden, name: "isHidden")
        b.bindIfPresent(\.opaque, name: "isOpaque")
        b.bindIfPresent(\.backgroundColor, name: "backgroundColor")
        b.bindIfPresent(\.translatesAutoresizingMaskIntoConstraints, name: "translatesAutoresizingMaskIntoConstraints")

        let shouldOverwriteTAMIC: Bool = {
            if view.constraints == nil { return true }
            if let constraints = view.constraints, constraints.isEmpty {
                return true
            }
            return false
        }()
        if shouldOverwriteTAMIC {
            builder.addProperty("translatesAutoresizingMaskIntoConstraints", value: true)
        }

        b.bindIfPresent(\.contentMode, name: "contentMode") {
            EnumCase($0)
        }

        if let priority = view.verticalHuggingPriority {
            builder.addMethodCall("setContentHuggingPriority", arguments: [
                (label: nil, value: RawValueString("UILayoutPriority(\(priority))")),
                (label: "for", value: EnumCase("vertical")),
            ])
        }

        if let priority = view.horizontalHuggingPriority {
            builder.addMethodCall("setContentHuggingPriority", arguments: [
                (label: nil, value: RawValueString("UILayoutPriority(\(priority))")),
                (label: "for", value: EnumCase("horizontal")),
            ])
        }

        if let priority = view.verticalCompressionResistancePriority {
            builder.addMethodCall("setContentCompressionResistancePriority", arguments: [
                (label: nil, value: RawValueString("UILayoutPriority(\(priority))")),
                (label: "for", value: EnumCase("vertical")),
            ])
        }

        if let priority = view.horizontalCompressionResistancePriority {
            builder.addMethodCall("setContentCompressionResistancePriority", arguments: [
                (label: nil, value: RawValueString("UILayoutPriority(\(priority))")),
                (label: "for", value: EnumCase("horizontal")),
            ])
        }

        if let constraints = view.constraints {
            builder.setConstraints(constraints)
        }
    }
}
