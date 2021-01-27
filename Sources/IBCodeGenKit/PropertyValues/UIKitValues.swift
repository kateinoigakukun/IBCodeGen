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


extension Size: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) throws where Target : IndentTextOutputStream {
        target.write("CGSize(width: \(width), height: \(height))")
    }
}

extension Font: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        if let metaFont = metaFont {
            let fontSize: Int
            switch metaFont {
            case "toolTip":
                fontSize = 11
            case "system":
                fontSize = size.flatMap { Int($0) } ?? 13
            default:
                fatalError()
            }
            target.write("UIFont.systemFont(ofSize: \(fontSize))")
        } else if let style = style, style.hasPrefix("UICTFontTextStyle") {
            var styleCase = String(style.dropFirst("UICTFontTextStyle".count))
            let headChar = styleCase.first!.lowercased()
            styleCase = headChar + styleCase.dropFirst(1)
            target.write("UIFont.preferredFont(forTextStyle: .\(styleCase))")
        } else {
            preconditionFailure()
        }
    }
}

extension ParagraphStyle: SwiftValueRepresentable {
    var isDefaultValue: Bool {
        if let alignment = alignment, alignment != "natural" {
            return false
        }
        if let lineBreakMode = lineBreakMode.map(LineBreakMode.init),
           lineBreakMode != .wordWrapping
        {
            return false
        }
        if let baseWritingDirection = baseWritingDirection, baseWritingDirection != "natural" {
            return false
        }
        if let allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation,
           allowsDefaultTighteningForTruncation // default is false
        {
            return false
        }
        return true
    }

    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        if isDefaultValue {
            target.write("NSParagraphStyle()")
            return
        }
        target.write("{\n")
        target.indented { (target) in
            target.writeLine("let style = NSMutableParagraphStyle()")
            if let alignment = alignment, alignment != "natural" {
                target.writeLine { line in
                    line.write("style.alignment = ")
                    EnumCase(alignment).writeValue(target: &line, context: context)
                }
            }
            if let lineBreakMode = lineBreakMode.map(LineBreakMode.init),
               lineBreakMode != .wordWrapping
            {
                target.writeLine { line in
                    line.write("style.lineBreakMode = ")
                    lineBreakMode.writeValue(target: &line, context: context)
                }
            }
            if let baseWritingDirection = baseWritingDirection, baseWritingDirection != "natural" {
                target.writeLine { line in
                    line.write("style.baseWritingDirection = ")
                    EnumCase(baseWritingDirection).writeValue(target: &line, context: context)
                }
            }
            if let allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation,
               allowsDefaultTighteningForTruncation // default is false
            {
                target.writeLine { line in
                    line.write("style.allowsDefaultTighteningForTruncation = ")
                    allowsDefaultTighteningForTruncation.writeValue(target: &line, context: context)
                }
            }
            target.writeLine("return style")
        }
        target.writeIndent()
        target.write("}()")
    }
}


extension Color: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) throws where Target : IndentTextOutputStream {
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
                    try target.indented { target in
                        target.writeLine("if #available(iOS 13.0, *) {")
                        target.indented { target in
                            target.writeLine("return UIColor.\(systemColorName)")
                        }
                        target.writeLine("} else {")
                        try target.indented { target in
                            target.writeIndent()
                            target.write("return ")
                            try backportingColor.writeValue(target: &target, context: context)
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
        case .catalog((_, let name, let catalog)):
            // FIXME: Adhoc transformation from `NSColor(catalogName:colorName:)`
            switch (name, catalog) {
            case ("textColor", "System"):
                target.write("UIColor(red: 0, green: 0, blue: 0, alpha: 1)")
            default:
                throw Error.catalogColorIsNotSupported(self)
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
            // Workaround: `UIFont.boldSystemFont` returns "SFUI-Semibold" instead of "SFUI-Bold"
            // https://jihyunsblog.wordpress.com/2020/11/20/boldsystemfont-returns-semibold
            if type == "boldSystem" {
                target.write("UIFont.systemFont(ofSize: \(pointSize), weight: .bold)")
            } else {
                target.write("UIFont.\(type)Font(ofSize: \(pointSize))")
            }
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
    case characterWrap
    case headTruncation
    case tailTruncation
    case middleTruncation
    case wordWrapping, wordWrap

    init(_ rawValue: String) {
        self.init(rawValue: rawValue)!
    }
}

extension LineBreakMode: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) where Target : IndentTextOutputStream {
        switch self {
        case .characterWrap:
            target.write(".byCharWrapping")
        case .headTruncation:
            target.write(".byTruncatingHead")
        case .tailTruncation:
            target.write(".byTruncatingTail")
        case .middleTruncation:
            target.write(".byTruncatingMiddle")
        case .wordWrapping, .wordWrap:
            target.write(".byWordWrapping")
        }
    }
}

struct Image {
    let name: String
    let catalog: String?
    let renderingMode: RenderingMode?
    let symbolScale: String?
    let symbolTrait: TraitCollection?

    enum RenderingMode: String {
        case automatic = "automatic"
        case alwaysOriginal = "original"
        case alwaysTemplate = "template"
    }

    init(name: String, catalog: String?,
         renderingMode: String? = nil,
         symbolScale: String? = nil,
         symbolConfiguration: TraitCollection? = nil) {
        self.name = name
        self.catalog = catalog
        self.renderingMode = renderingMode.flatMap(RenderingMode.init(rawValue: ))
        self.symbolScale = symbolScale
        self.symbolTrait = symbolConfiguration
    }
}

extension Image: SwiftValueRepresentable {
    private func writeAssetCatalog<Target: IndentTextOutputStream>(target: inout Target, context: CodeGenContext) throws {
        target.write("UIImage(named: \"\(name)\", in: Bundle(for: Self.self), compatibleWith: nil)!")
        if let renderingMode = renderingMode {
            target.write(".withRenderingMode(.\(renderingMode))")
        }
    }
    private func writeSymbolConfiguration<Target: IndentTextOutputStream>(target: inout Target) {
        guard let symbolScale = symbolScale else {
            target.write("UIImage.SymbolConfiguration.unspecified")
            return
        }
        target.write("UIImage.SymbolConfiguration(scale: .\(symbolScale))")
    }
    func writeValue<Target>(target: inout Target, context: CodeGenContext) throws where Target : IndentTextOutputStream {
        if let catalog = catalog, catalog == "system" {
            target.write("{\n")
            try target.indented { (target) in
                target.writeLine("if #available(iOS 13.0, *) {")
                try target.indented { target in
                    try target.writeLine { line in
                        line.write("return UIImage(systemName: \"\(name)\", withConfiguration: ")
                        if let trait = symbolTrait {
                            writeSymbolConfiguration(target: &line)
                            line.write(".withTraitCollection(")
                            try trait.writeValue(target: &line, context: context)
                            line.write(")")
                        } else {
                            writeSymbolConfiguration(target: &line)
                        }
                        line.write(")!")
                        if let renderingMode = renderingMode {
                            line.write(".withRenderingMode(.\(renderingMode))")
                        }
                    }
                }
                target.writeLine("} else {")
                try target.indented { target in
                    try target.writeLine { line in
                        line.write("return ")
                        try writeAssetCatalog(target: &line, context: context)
                    }
                }
                target.writeLine("}")
            }
            target.writeIndent()
            target.write("}()")
        } else {
            try writeAssetCatalog(target: &target, context: context)
        }
    }
}

enum TraitCollection {
    case buttonSymbolImage
    case imageViewSymbolImage
}

extension TraitCollection: SwiftValueRepresentable {
    var userInterfaceIdiom: String? {
        switch self {
        case .buttonSymbolImage, .imageViewSymbolImage:
            return "pad"
        }
    }

    var displayScale: Int? {
        switch self {
        case .buttonSymbolImage, .imageViewSymbolImage:
            return 1
        }
    }

    var displayGamut: String? {
        switch self {
        case .buttonSymbolImage, .imageViewSymbolImage:
            return "SRGB"
        }
    }

    func writeValue<Target>(target: inout Target, context: CodeGenContext) throws where Target : IndentTextOutputStream {
        target.write(".current")
        // FIXME: The default value of UITraitCollection in UIImage.SymbolConfiguration can be changed
        // based on runtime OS version, but I don't have enough time to investigate each default value,
        // so use `.current` for every OSs.

        /*
        switch self {
        case .imageViewSymbolImage, .buttonSymbolImage:
            target.write(".current")
        default:
            target.write("{\n")
            target.indented { target in
                target.writeLine("return UITraitCollection(traitsFrom: [")
                if let userInterfaceIdiom = userInterfaceIdiom {
                    target.indented { $0.writeLine("UITraitCollection(userInterfaceIdiom: .\(userInterfaceIdiom)),") }
                }
                if let displayScale = displayScale {
                    target.indented { $0.writeLine("UITraitCollection(displayScale: \(displayScale)),") }
                }
                if let displayGamut = displayGamut {
                    target.indented { $0.writeLine("UITraitCollection(displayGamut: .\(displayGamut)),") }
                }
                target.writeLine("])")
            }
            target.writeIndent()
            target.write("}()")
        }
        */
    }
}

extension ImageReference: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) throws where Target : IndentTextOutputStream {
        guard let image = image else {
            target.write("UIImage()")
            return
        }
        try Image(name: image, catalog: catalog, renderingMode: renderingMode, symbolScale: symbolScale)
            .writeValue(target: &target, context: context)
    }
}

extension PreferredSymbolConfiguration: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) throws where Target : IndentTextOutputStream {
        target.write("UIImage.SymbolConfiguration(")
        var arguments: [Argument] = []
        switch configuration {
        case .pointSize(let size):
            arguments.append((label: "pointSize", value: size))
        case .font(let font):
            arguments.append((label: "font", value: font))
        case .unknown, nil:
            break
        }
        if let weight = weight {
            arguments.append((label: "weight", value: EnumCase(weight)))
        }
        if let scale = scale {
            arguments.append((label: "scale", value: EnumCase(scale)))
        }
        try ArgumentList(arguments: arguments).writeValue(target: &target, context: context)
        target.write(")")
    }
}

extension Inset: SwiftValueRepresentable {
    func writeValue<Target>(target: inout Target, context: CodeGenContext) throws where Target : IndentTextOutputStream {
        target.write("UIEdgeInsets(")
        let arguments: [Argument] = [
            ("top", minY ?? 0), ("left", minX ?? 0),
            ("bottom", maxY ?? 0), ("right", maxX ?? 0),
        ]
        try ArgumentList(arguments: arguments).writeValue(target: &target, context: context)
        target.write(")")
    }
}
