//
//  UIView.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable

extension AnyView: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootViewCodeBuilder) throws {
        func bind<V: SwiftValueRepresentable>(_ keyPath: KeyPath<ViewProtocol, V>, name: String) {
            builder.addProperty(name, value: view[keyPath: keyPath])
        }
        func bindIfPresent<V1: SwiftValueRepresentable, V2: SwiftValueRepresentable>(
            _ keyPath: KeyPath<ViewProtocol, V1?>, name: String, transform: (V1) -> V2) {
            if let value = view[keyPath: keyPath] {
                builder.addProperty(name, value: transform(value))
            }
        }
        func bindIfPresent<V: SwiftValueRepresentable>(
            _ keyPath: KeyPath<ViewProtocol, V?>, name: String
        ) {
            bindIfPresent(keyPath, name: name, transform: { $0 })
        }

        builder.addProperty("autoresizingMask", value: view.autoresizingMask ?? .default)
        bindIfPresent(\.rect, name: "frame")
        bindIfPresent(\.userInteractionEnabled, name: "isUserInteractionEnabled")
        bindIfPresent(\.backgroundColor, name: "backgroundColor")
        bindIfPresent(\.translatesAutoresizingMaskIntoConstraints, name: "translatesAutoresizingMaskIntoConstraints")
        bindIfPresent(\.contentMode, name: "contentMode") {
            EnumCase($0)
        }
        if let constraints = view.constraints {
            builder.setConstraints(constraints)
        }
    }
}
