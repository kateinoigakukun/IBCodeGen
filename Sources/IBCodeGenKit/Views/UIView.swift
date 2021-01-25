//
//  UIView.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable

extension AnyView: CodeGenTargetView {
    func validate() throws {
        if let variations = view.variations, !variations.isEmpty {
            throw Error.sizeClassIsNotSupported(view)
        }
    }

    func codegen(builder: ViewCodeBuilder, rootView: RootViewClass) throws {
        let b = ViewBinder(view: self.view, builder: builder,
                           assumeClassDefault: view.customClass == nil)
        builder.addProperty("autoresizingMask", value: view.autoresizingMask ?? .default)
        b.bindIfPresent(\.rect, name: "frame")
        b.bindIfPresent(\.userInteractionEnabled, classDefault: true, name: "isUserInteractionEnabled")
        b.bindIfPresent(\.isHidden, classDefault: false, name: "isHidden")
        b.bindIfPresent(\.clipsSubviews, name: "clipsToBounds")
        b.bindIfPresent(\.opaque, classDefault: true, name: "isOpaque")
        b.bindIfPresent(\.backgroundColor, name: "backgroundColor")
        b.bindIfPresent(\.tintColor, name: "tintColor")
        b.bindIfPresent(\.translatesAutoresizingMaskIntoConstraints, classDefault: true,
                        name: "translatesAutoresizingMaskIntoConstraints")

        let shouldOverwriteTAMIC: Bool = {
            if view.constraints == nil { return true }
            if let constraints = view.constraints, constraints.isEmpty {
                return true
            }
            return false
        }()
        if shouldOverwriteTAMIC && view.translatesAutoresizingMaskIntoConstraints == false {
            builder.addProperty("translatesAutoresizingMaskIntoConstraints", value: true)
        }

        b.bindIfPresent(\.contentMode, classDefault: "scaleToFill",
                        name: "contentMode", transform: EnumCase.init)

        if let priority = view.verticalHuggingPriority {
            builder.addMethodCall("setContentHuggingPriority", arguments: [
                (label: nil, value: LayoutPriority(value: priority)),
                (label: "for", value: EnumCase("vertical")),
            ])
        }

        if let priority = view.horizontalHuggingPriority {
            builder.addMethodCall("setContentHuggingPriority", arguments: [
                (label: nil, value: LayoutPriority(value: priority)),
                (label: "for", value: EnumCase("horizontal")),
            ])
        }

        if let priority = view.verticalCompressionResistancePriority {
            builder.addMethodCall("setContentCompressionResistancePriority", arguments: [
                (label: nil, value: LayoutPriority(value: priority)),
                (label: "for", value: EnumCase("vertical")),
            ])
        }

        if let priority = view.horizontalCompressionResistancePriority {
            builder.addMethodCall("setContentCompressionResistancePriority", arguments: [
                (label: nil, value: LayoutPriority(value: priority)),
                (label: "for", value: EnumCase("horizontal")),
            ])
        }

        if let constraints = view.constraints {
            builder.setConstraints(constraints)
        }
    }
}

extension View: CodeGenTargetView {
    func validate() throws {
        if let simulatedNavigationBarMetrics = simulatedNavigationBarMetrics,
           let translucent = simulatedNavigationBarMetrics.translucent, !translucent {
            throw Error.opaqueBarIsNotSupported(self)
        }

        if let simulatedToolbarMetrics = simulatedToolbarMetrics,
           let translucent = simulatedToolbarMetrics.translucent, !translucent {
            throw Error.opaqueBarIsNotSupported(self)
        }

        if let simulatedTabBarMetrics = simulatedTabBarMetrics,
           let translucent = simulatedTabBarMetrics.translucent, !translucent {
            throw Error.opaqueBarIsNotSupported(self)
        }

        if modalPageSheetSimulatedSizeMetrics != nil || modalFormSheetSimulatedSizeMetrics != nil {
            throw Error.modalSheetIsNotSupported(self)
        }
    }
    func codegen(builder: ViewCodeBuilder, rootView: RootViewClass) throws {}
}
