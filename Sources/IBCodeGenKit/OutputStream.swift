protocol IndentTextOutputStream {
    mutating func writeLine(_ line: String)
    mutating func indented(_ body: (inout Self) -> Void)
}

struct GenericIndentTextOutputStream<Downstream: TextOutputStream>: IndentTextOutputStream {
    private var indentLevel: Int = 0
    private var downstream: Downstream
    let indent: Int
    init(downstream: Downstream, indent: Int = 4) {
        self.downstream = downstream
        self.indent = indent
    }

    mutating func writeLine(_ line: String) {
        downstream.write(String(repeating: " ", count: indentLevel * indent) + line + "\n")
    }
    mutating func indented(_ body: (inout GenericIndentTextOutputStream) -> Void) {
        indentLevel += 1
        body(&self)
        indentLevel -= 1
    }
}
