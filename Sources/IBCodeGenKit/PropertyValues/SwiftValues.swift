//
//  SwiftValues.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import Foundation


extension String: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        target.write("\"\(self)\"")
    }
}

extension Bool: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        target.write(self.description)
    }
}

extension Float: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        target.write(self.description)
    }
}

struct EnumCase: SwiftValueRepresentable {
    let caseValue: String
    init(_ caseValue: String) {
        self.caseValue = caseValue
    }

    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        target.write("." + caseValue)
    }
}

struct RawValueString: SwiftValueRepresentable {
    let rawString: String
    init(_ rawString: String) {
        self.rawString = rawString
    }
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        target.write(rawString)
    }
}

struct DictionaryValue: SwiftValueRepresentable {
    typealias Entry = (key: SwiftValueRepresentable, value: SwiftValueRepresentable)
    let entries: [Entry]
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        target.write("[\n")
        target.indented { target in
            for (index, entry) in entries.enumerated() {
                target.writeLine { target in
                    entry.key.writeValue(target: &target, context: context)
                    target.write(": ")
                    entry.value.writeValue(target: &target, context: context)
                    if index + 1 != entries.endIndex {
                        target.write(", ")
                    }
                }
            }
        }
        target.writeIndent()
        target.write("]")
    }
}
