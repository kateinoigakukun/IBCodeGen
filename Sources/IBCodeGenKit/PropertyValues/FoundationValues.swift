//
//  FoundationValues.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import Foundation
import IBDecodable

extension AttributedString: SwiftValueRepresentable {
    var isNilValue: Bool {
        guard let fragments = fragments, !fragments.isEmpty else {
            return true
        }
        return false
    }
    func writeValue<Target>(target: inout Target, context: CodeGenContext) throws where Target : IndentTextOutputStream {
        guard let fragments = fragments, !fragments.isEmpty else {
            target.write("nil")
            return
        }
        if let fragment = fragments.first, fragments.count == 1 {
            try fragment.writeValue(target: &target, context: context)
            return
        }

        target.write("{\n")
        try target.indented { target in
            target.writeLine("let string = NSMutableAttributedString()")
            for fragment in fragments {
                try target.writeLine { line in
                    line.write("string.append(")
                    try fragment.writeValue(target: &line, context: context)
                    line.write(")")
                }
            }
            target.writeLine("return string")
        }
        target.writeIndent()
        target.write("}()")
    }
}


extension AttributedString.Fragment: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) throws where Target : IndentTextOutputStream {
        let string = content
        guard let attributes = attributes else {
            target.write("NSAttributedString(string: ")
            string.writeValue(target: &target, context: context)
            target.write(")")
            return
        }
        let attributesEntries = attributes.compactMap { attr -> DictionaryValue.Entry? in
            switch attr.attribute {
            case let font as Font:
                return (key: EnumCase("font"), value: font)
            case let style as ParagraphStyle:
                return (key: EnumCase("paragraphStyle"), value: style)
            case let color as Color where color.key == "NSColor":
                return (key: EnumCase("foregroundColor"), value: color)
            case let color as Color where color.key == "NSBackgroundColor":
                return (key: EnumCase("backgroundColor"), value: color)
            default:
                fatalError()
            }
        }

        target.write("NSAttributedString(string: ")
        string.writeValue(target: &target, context: context)
        target.write(", attributes: ")
        try DictionaryValue(entries: attributesEntries).writeValue(target: &target, context: context)
        target.write(")")
    }
}
