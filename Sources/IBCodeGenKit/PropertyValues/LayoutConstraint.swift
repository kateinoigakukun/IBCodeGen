//
//  LayoutConstraint.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/23.
//

import Foundation
import IBDecodable

struct LayoutAnchor {
    let item: String
    let attribute: Constraint.LayoutAttribute
}

extension LayoutAnchor: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        let attributeString = attribute.caseName.hasSuffix("Margin")
            ? String(attribute.caseName.dropLast("Margin".count))
            : attribute.caseName
        target.write("\(item).\(attributeString)Anchor")
    }
}

fileprivate extension Constraint.LayoutAttribute {
    var hasSystemMargin: Bool {
        switch self {
        case .topMargin, .bottomMargin, .leftMargin, .rightMargin,
             .leadingMargin, .trailingMargin:
            return true
        default:
            return false
        }
    }
}

extension Constraint {
    private static func targetExpression(item: String, context: CodeGenContext) -> String {
        guard let element = context.hierarchy.element(byId: item) else {
            fatalError("'\(item)' is unknown element in view")
        }
        if element is ViewProtocol {
            return context.namespace.getIdentifier(id: item)
        } else if let guide = element as? LayoutGuide {
            return "contentView.\(guide.key)LayoutGuide"
        }
        fatalError("unreachable")
    }

    private func writeAnchorRelation<Target>(
        target: inout Target, context: CodeGenContext, selfView: String
    ) where Target : IndentTextOutputStream {

        guard let firstAttribute = firstAttribute else { fatalError("unexpected firstAttribute nil") }

        let firstAnchor: LayoutAnchor
        if let firstItem = firstItem {
            firstAnchor = LayoutAnchor(
                item: Self.targetExpression(item: firstItem, context: context),
                attribute: firstAttribute
            )
        } else {
            firstAnchor = LayoutAnchor(
                item: context.namespace.getIdentifier(id: selfView),
                attribute: firstAttribute
            )
        }

        let secondAnchor: LayoutAnchor?
        if let secondItem = secondItem, let secondAttribute = secondAttribute {
            secondAnchor = LayoutAnchor(
                item: Self.targetExpression(item: secondItem, context: context),
                attribute: secondAttribute
            )
        } else {
            secondAnchor = nil
        }

        var arguments: [Argument] = []
        switch (secondAnchor, multiplier, constant) {
        case let (nil, nil, constant?):
            arguments.append((label: "\(relation.caseName)ToConstant", value: constant))
        case let (secondAnchor?, multiplier, constant):
            assert(!firstAnchor.attribute.hasSystemMargin) // TODO: Support relative to margin
            arguments.append((label: "\(relation.caseName)To", value: secondAnchor))
            if let multiplier = multiplier {
                arguments.append((label: "multiplier", value: multiplier))
            }
            if let constant = constant {
                arguments.append((label: "constant", value: constant))
            }
        case (nil, _?, _?), (nil, _?, nil), (nil, nil, nil):
            fatalError("unreachable")
        }
        firstAnchor.writeValue(target: &target, context: context)
        target.write(".constraint(")
        ArgumentList(arguments: arguments).writeValue(target: &target, context: context)
        target.write(")")
    }

    func writeValue<Target>(target: inout Target, context: CodeGenContext, selfView: String) where Target : IndentTextOutputStream {
        guard let priority = priority else {
            writeAnchorRelation(target: &target, context: context, selfView: selfView)
            return
        }
        target.write("{\n")
        target.indented { target in
            target.writeIndent()
            target.write("let constraint = ")
            writeAnchorRelation(target: &target, context: context, selfView: selfView)
            target.write("\n")
            target.writeLine("constraint.priority = UILayoutPriority(\(priority))")
            target.writeLine("return constraint")
        }
        target.writeIndent()
        target.write("}()")
    }
}
