import IBDecodable

internal protocol SwiftValueRepresentable {
    func swiftValue<Target: IndentTextOutputStream>( target: inout Target)
}

extension AutoresizingMask: SwiftValueRepresentable {
    func swiftValue<Target>(target: inout Target) where Target : IndentTextOutputStream {
        var mask: [String] = []
        if widthSizable {
            mask.append("flexibleWidth")
        }
        if heightSizable {
            mask.append("flexibleHeight")
        }
        if flexibleMinX {
            mask.append("flexibleLeftMargin")
        }
        if flexibleMaxX {
            mask.append("flexibleRightMargin")
        }
        if flexibleMinY {
            mask.append("flexibleTopMargin")
        }
        if flexibleMaxY {
            mask.append("flexibleBottomMargin")
        }
        target.writeLine(<#T##line: String##String#>) "[\(mask.map { ".\($0)" }.joined(separator: ", "))]"
    }
}

extension Rect: SwiftValueRepresentable {
    func swiftValue() -> String {
        return "CGRect(x: \(x), y: \(y), width: \(width), height: \(height))"
    }
}

extension Font: SwiftValueRepresentable {
    func swiftValue() -> String {
        guard let metaFont = metaFont else {
            preconditionFailure()
        }
        let fontSize: Int
        switch metaFont {
        case "toolTip":
            fontSize = 11
        case "system":
            fontSize = Int(size!)!
        default:
            fatalError()
        }
        return "UIFont.systemFont(ofSize: \(fontSize))"
    }
}

extension ParagraphStyle: SwiftValueRepresentable {
    func swiftValue() -> String {
        alignment
        switch <#value#> {
        case <#pattern#>:
            <#code#>
        default:
            <#code#>
        }
    }
}

func makeDictionary(dictionaryLiteral: [(key: SwiftValueRepresentable, value: SwiftValueRepresentable)]) -> String {
    "[" + dictionaryLiteral.map { "\($0.key.swiftValue()): \($0.value.swiftValue())" }.joined(separator: ", ") + "]"
}

extension AttributedString: SwiftValueRepresentable {
    func swiftValue() -> String {
        precondition(fragments == nil || fragments?.count == 1)
        guard let fragment = fragments?.first else {
            return "NSAttributedString()"
        }
        let string = fragment.content
        guard let attributes = fragment.attributes else {
            return "NSAttributedString(string: \(string.swiftValue()))"
        }
        let attributesArg = attributes.map { attr -> (key: SwiftValueRepresentable, value: SwiftValueRepresentable) in
            switch attr.attribute {
            case let font as Font:
                return (key: EnumCase("font"), value: font)
            case let style as ParagraphStyle:
                return (key: EnumCase("paragraphStyle"), value: style)
            default:
                fatalError()
            }
        }

        return "NSAttributedString(string: \(string.swiftValue()), attributes: \(makeDictionary(dictionaryLiteral: attributesArg)))"
    }
}


extension String: SwiftValueRepresentable {
    func swiftValue() -> String { "\"\(self)\"" }
}

struct EnumCase: SwiftValueRepresentable {
    let caseValue: String
    init(_ caseValue: String) {
        self.caseValue = caseValue
    }

    func swiftValue() -> String {
        "." + caseValue
    }
}
