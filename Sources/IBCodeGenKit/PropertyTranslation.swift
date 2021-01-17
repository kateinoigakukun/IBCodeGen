import IBDecodable

internal protocol SwiftValueRepresentable {
    func writeValue<Target: IndentTextOutputStream>(target: inout Target, context: CodeGenContext)
}
