//
//  UIKitValues.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/18.
//

import IBDecodable

extension AutoresizingMask: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
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
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        target.write("CGRect(x: \(x), y: \(y), width: \(width), height: \(height))")
    }
}

extension Font: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
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
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        target.write("{\n")
        target.indented { (target) in
            target.writeLine("let style = NSMutableParagraphStyle()")
            if let alignment = alignment {
                target.writeLine { line in
                    line.write("style.alignment = ")
                    EnumCase(alignment).writeValue(target: &line, context: context)
                }
            }
            target.writeLine("return style")
        }
        target.writeIndent()
        target.write("}()")
    }
}


extension Color: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        switch self {
        case .calibratedRGB,
             .calibratedWhite:
            fatalError("not supported yet")
        case .sRGB((_, let red, let blue, let green, let alpha)):
            target.write("UIColor(red: \(red), green: \(green), blue: \(blue), alpha: \(alpha))")
        case .name((_, let name)):
            target.write("UIColor(named: ")
            name.writeValue(target: &target, context: context)
            target.write(")")
        case .systemColor((_, let name)):
            if name == "systemBackgroundColor" {
                // systemBackgroundColor is now renamed
                if context.isSupportingDarkMode {
                    target.write("UIColor.systemBackground")
                } else {
                    target.write("{\n")
                    target.indented { target in
                        target.writeLine("if #available(iOS 13.0, *) {")
                        target.indented { target in
                            target.writeLine("return UIColor.systemBackground")
                        }
                        target.writeLine("} else {")
                        target.indented { target in
                            target.writeLine("return UIColor.white")
                        }
                        target.writeLine("}")
                    }
                    target.writeIndent()
                    target.write("}()")
                }
            } else if name.range(of: #"^system(\w+)Color$"#, options: .regularExpression) != nil {
                target.write("UIColor.\(name.dropLast("Color".count))")
            } else {
                target.write("UIColor.\(name)")
            }
        }

    }
}
