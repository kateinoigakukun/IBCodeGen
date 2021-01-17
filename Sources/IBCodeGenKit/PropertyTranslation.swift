import IBDecodable

internal protocol SwiftValueRepresentable {
    func writeValue<Target: IndentTextOutputStream>(target: inout Target)
}

extension AutoresizingMask: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target) where Target : IndentTextOutputStream {
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
        target.write("[\(mask.map { ".\($0)" }.joined(separator: ", "))]")
    }
}

extension Rect: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target) where Target : IndentTextOutputStream {
        target.write("CGRect(x: \(x), y: \(y), width: \(width), height: \(height))")
    }
}

extension Font: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target) where Target : IndentTextOutputStream {
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
        target.write("UIFont.systemFont(ofSize: \(fontSize))")
    }
}

extension ParagraphStyle: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target) where Target : IndentTextOutputStream {
        target.write("{\n")
        target.indented { (target) in
            target.writeLine("let style = NSMutableParagraphStyle()")
            if let alignment = alignment {
                target.writeLine { line in
                    line.write("style.alignment = ")
                    EnumCase(alignment).writeValue(target: &line)
                }
            }
            target.writeLine("return style")
        }
        target.writeIndent()
        target.write("}()")
    }
}

struct DictionaryValue: SwiftValueRepresentable {
    typealias Entry = (key: SwiftValueRepresentable, value: SwiftValueRepresentable)
    let entries: [Entry]
    func writeValue<Target>(target: inout Target) where Target : IndentTextOutputStream {
        target.write("[\n")
        target.indented { target in
            for (index, entry) in entries.enumerated() {
                target.writeLine { target in
                    entry.key.writeValue(target: &target)
                    target.write(": ")
                    entry.value.writeValue(target: &target)
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

extension AttributedString: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target) where Target : IndentTextOutputStream {
        precondition(fragments == nil || fragments?.count == 1)
        guard let fragment = fragments?.first else {
            target.write("NSAttributedString()")
            return
        }
        let string = fragment.content
        guard let attributes = fragment.attributes else {
            target.write("NSAttributedString(string: ")
            string.writeValue(target: &target)
            target.write(")")
            return
        }
        let attributesEntries = attributes.map { attr -> DictionaryValue.Entry in
            switch attr.attribute {
            case let font as Font:
                return (key: EnumCase("font"), value: font)
            case let style as ParagraphStyle:
                return (key: EnumCase("paragraphStyle"), value: style)
            default:
                fatalError()
            }
        }

        target.write("NSAttributedString(string: ")
        string.writeValue(target: &target)
        target.write(", attributes: ")
        DictionaryValue(entries: attributesEntries).writeValue(target: &target)
        target.write(")")
    }
}


extension String: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target) where Target : IndentTextOutputStream {
        target.write("\"\(self)\"")
    }
}

struct EnumCase: SwiftValueRepresentable {
    let caseValue: String
    init(_ caseValue: String) {
        self.caseValue = caseValue
    }

    func writeValue<Target>(target: inout Target) where Target : IndentTextOutputStream {
        target.write("." + caseValue)
    }
}
