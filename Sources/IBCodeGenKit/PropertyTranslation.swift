import IBDecodable

internal protocol SwiftValueRepresentable {
    func swiftValue() -> String
}

extension AutoresizingMask: SwiftValueRepresentable {
    func swiftValue() -> String {
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
        return "[\(mask.map { ".\($0)" }.joined(separator: ", "))]"
    }
}

extension Rect: SwiftValueRepresentable {
    func swiftValue() -> String {
        return "CGRect(x: \(x), y: \(y), width: \(width), height: \(height))"
    }
}
