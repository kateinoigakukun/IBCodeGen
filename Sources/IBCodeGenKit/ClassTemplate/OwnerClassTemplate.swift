//
//  OwnerClassTemplate.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/27.
//

import Foundation

class OwnerClassClass: RootClassBuilder {
    let className: String
    let id: String
    private var subviews: [ViewElement] = []

    init(baseClassName: String, id: String) {
        self.className = baseClassName + "_Owner"
        self.id = id
    }

    func makeSubview(id: String, className: String, elementClass: String, userLabel: String?) -> ViewCodeBuilder {
        let subview = ViewElement(id: id, className: className, elementClass: elementClass, userLabel: userLabel)
        subviews.append(subview)
        return subview
    }

    func build<Target: IndentTextOutputStream>(target: inout Target, context: inout CodeGenContext) throws {
        target.writeLine("class \(className): NSObject {")
        try target.indented { target in
            for subview in subviews {
                try subview.build(target: &target, context: &context)
            }

            if subviews.contains(where: \.shouldWriteConstraintsActivation) {
                target.writeLine("func activateConstraints() {")
                try target.indented { target in
                    for subview in subviews {
                        try subview.buildConstraintsActivation(target: &target, context: &context)
                    }
                }
                target.writeLine("}")

                target.writeLine("override init() {")
                target.indented { target in
                    target.writeLine("super.init()")
                    target.writeLine("activateConstraints()")
                }
                target.writeLine("}")
            }

            let identifier = context.namespace.getIdentifier(id: id)
            target.writeLine("var contentView: UIView {")
            target.indented {
                $0.writeLine("return \(identifier)")
            }
            target.writeLine("}")
        }
        target.writeLine("}")
    }
}
