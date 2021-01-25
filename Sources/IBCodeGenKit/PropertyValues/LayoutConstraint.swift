//
//  LayoutConstraint.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/23.
//

import Foundation
import IBDecodable

fileprivate struct LayoutAnchor {
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

struct LayoutPriority {
    let value: Int
}

fileprivate extension Array where Element: Comparable, Element: AdditiveArithmetic {
    func closest(for value: Element) -> Element? {
        sorted().closestInSorted(for: value)
    }
    private func closestInSorted(for value: Element) -> Element? {
        guard let greaterIndex = firstIndex(where: { $0 > value }) else {
            return last
        }
        guard greaterIndex > startIndex else { return first }
        guard greaterIndex < endIndex else { return last }
        let lesserIndex = greaterIndex.advanced(by: -1)
        if (self[greaterIndex] - value) < (value - self[lesserIndex]) {
            return self[greaterIndex]
        } else {
            return self[lesserIndex]
        }
    }
}

extension LayoutPriority: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        // Refer: <UIKit/NSLayoutConstraint.h>
        let staticPriorities = [
            1000: "required",
            750: "defaultHigh",
            510: "dragThatCanResizeScene",
            500: "sceneSizeStayPut",
            490: "dragThatCannotResizeScene",
            250: "defaultLow",
            50: "fittingSizeLevel"
        ]
        if let closestPriority = Array(staticPriorities.keys).closest(for: value),
           let staticCase = staticPriorities[closestPriority] {
            let diff = value - closestPriority
            if diff > 0 {
                target.write(".\(staticCase) + \(diff)")
            } else if diff < 0 {
                target.write(".\(staticCase) - \(-diff)")
            } else { // diff == 0
                target.write(".\(staticCase)")
            }
        } else {
            target.write("UILayoutPriority(\(value))")
        }
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

    private static func evaluate(multiplier: String) -> Float {
        if let validFloat = Float(multiplier) {
            return validFloat
        }
        let parts = multiplier.split(separator: ":")
        assert(parts.count == 2)
        let lhs = Float(parts[0])!
        let rhs = Float(parts[1])!
        return lhs/rhs
    }
    private func writeAnchorRelation<Target>(
        target: inout Target, context: CodeGenContext, selfView: String
    ) throws where Target : IndentTextOutputStream {

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
                arguments.append((label: "multiplier", value: Self.evaluate(multiplier: multiplier)))
            }
            if let constant = constant {
                arguments.append((label: "constant", value: constant))
            }
        case (nil, _?, _?), (nil, _?, nil), (nil, nil, nil):
            fatalError("unreachable")
        }
        firstAnchor.writeValue(target: &target, context: context)
        target.write(".constraint(")
        try ArgumentList(arguments: arguments).writeValue(target: &target, context: context)
        target.write(")")
    }

    func writeValue<Target>(target: inout Target, context: CodeGenContext, selfView: String) throws where Target : IndentTextOutputStream {
        guard let priority = priority else {
            try writeAnchorRelation(target: &target, context: context, selfView: selfView)
            return
        }
        target.write("{\n")
        try target.indented { target in
            target.writeIndent()
            target.write("let constraint = ")
            try writeAnchorRelation(target: &target, context: context, selfView: selfView)
            target.write("\n")
            target.writeLine { line in
                line.write("constraint.priority = ")
                LayoutPriority(value: priority).writeValue(target: &line, context: context)
            }
            target.writeLine("return constraint")
        }
        target.writeIndent()
        target.write("}()")
    }
}
