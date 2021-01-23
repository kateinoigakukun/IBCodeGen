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
            fontSize = size.flatMap { Int($0) } ?? 10 // FIXME
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
        case .calibratedWhite((_, let white, let alpha)):
            target.write("UIColor.init(white: \(white), alpha: \(alpha))")
        case .calibratedRGB:
            fatalError("not supported yet")
        case .sRGB((_, let red, let blue, let green, let alpha)):
            target.write("UIColor(red: \(red), green: \(green), blue: \(blue), alpha: \(alpha))")
        case .name((_, let name)):
            target.write("UIColor(named: ")
            name.writeValue(target: &target, context: context)
            target.write(")")
        case .genericGamma22Gray((_, let white, let alpha)):
            target.write("{\n")
            target.indented { target in
                target.writeLine("var components: [CGFloat] = [\(white), \(alpha)]")
                target.writeLine("let colorSpace = CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)!")
                target.writeLine("let cgColor = CGColor(colorSpace: colorSpace, components: &components)!")
                target.writeLine("return UIColor(cgColor: cgColor)")
            }
            target.writeIndent()
            target.write("}()")
        case .systemColor((_, let name)):
            if name.range(of: #"^system(\w+)Color$"#, options: .regularExpression) != nil {
                let systemColorName = name.dropLast("Color".count)
                if context.isSupportingDarkMode {
                    target.write("UIColor.\(systemColorName)")
                } else if let backportingColor = context.systemColor(name: name) {
                    target.write("{\n")
                    target.indented { target in
                        target.writeLine("if #available(iOS 13.0, *) {")
                        target.indented { target in
                            target.writeLine("return UIColor.\(systemColorName)")
                        }
                        target.writeLine("} else {")
                        target.indented { target in
                            target.writeIndent()
                            target.write("return ")
                            backportingColor.writeValue(target: &target, context: context)
                            target.write("\n")
                        }
                        target.writeLine("}")
                    }
                    target.writeIndent()
                    target.write("}()")
                } else {
                    fatalError("There should be backporting systemColor resource in IB")
                }
            } else {
                target.write("UIColor.\(name)")
            }
        }

    }
}

extension Constraint.LayoutAttribute: SwiftValueRepresentable {
    var caseName: String {
        switch self {
        case .other(let other): return other
        default: return String(describing: self)
        }
    }
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        EnumCase(caseName).writeValue(target: &target, context: context)
    }
}

extension Constraint.Relation: SwiftValueRepresentable {
    var caseName: String {
        switch self {
        case .other(let other): return other
        default: return String(describing: self)
        }
    }
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        EnumCase(caseName).writeValue(target: &target, context: context)
    }
}

extension FontDescription: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        switch self {
        case .system((_, let type, .none, let pointSize)):
            assert(type == "system")
            target.write("UIFont.systemFont(ofSize: \(pointSize))")
        case .system((_, _, .some(let weight), let pointSize)):
            target.write("UIFont.systemFont(ofSize: \(pointSize), weight: .\(weight))")
        case .custom((_, _, let family, let pointSize)):
            target.write("UIFont(name: \"\(family)\", size: \(pointSize))")
        case .textStyle((_, let style)):
            target.write("UIFont.preferredFont(forTextStyle: .\(style))")
        }
    }
}

enum LineBreakMode: String {
    case headTruncation
    case tailTruncation
    case middleTruncation

    init(_ rawValue: String) {
        self.init(rawValue: rawValue)!
    }
}

extension LineBreakMode: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        switch self {
        case .headTruncation:
            target.write(".byTruncatingHead")
        case .tailTruncation:
            target.write(".byTruncatingTail")
        case .middleTruncation:
            target.write(".byTruncatingMiddle")
        }
    }
}
