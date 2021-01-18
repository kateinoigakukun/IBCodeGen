//
//  FoundationValues.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import Foundation
import IBDecodable

extension AttributedString: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        precondition(fragments == nil || fragments?.count == 1)
        guard let fragment = fragments?.first else {
            target.write("NSAttributedString()")
            return
        }
        let string = fragment.content
        guard let attributes = fragment.attributes else {
            target.write("NSAttributedString(string: ")
            string.writeValue(target: &target, context: context)
            target.write(")")
            return
        }
        let attributesEntries = attributes.map { attr -> DictionaryValue.Entry in
            switch attr.attribute {
            case let font as Font:
                return (key: EnumCase("font"), value: font)
            case let style as ParagraphStyle:
                return (key: EnumCase("paragraphStyle"), value: style)
            case let color as Color:
                return (key: EnumCase("foregroundColor"), value: color)
            default:
                fatalError()
            }
        }

        target.write("NSAttributedString(string: ")
        string.writeValue(target: &target, context: context)
        target.write(", attributes: ")
        DictionaryValue(entries: attributesEntries).writeValue(target: &target, context: context)
        target.write(")")
    }
}
