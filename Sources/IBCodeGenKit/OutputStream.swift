protocol IndentTextOutputStream {
    mutating func writeLine(_ line: String)
    mutating func writeLine(_ line: (inout Self) throws -> Void) rethrows
    mutating func write(_ string: String)
    mutating func writeIndent()
    mutating func indented(_ body: (inout Self) throws -> Void) rethrows
}

struct GenericIndentTextOutputStream<Downstream: TextOutputStream>: IndentTextOutputStream {
    private var indentLevel: Int = 0
    private var downstream: Downstream
    let indent: Int
    init(downstream: Downstream, indent: Int = 4) {
        self.downstream = downstream
        self.indent = indent
    }

    mutating func writeLine(_ line: (inout Self) throws -> Void) rethrows {
        downstream.write(String(repeating: " ", count: indentLevel * indent))
        try line(&self)
        downstream.write("\n")
    }
    mutating func writeLine(_ line: String) {
        writeLine {
            $0.write(line)
        }
    }
    mutating func write(_ string: String) {
        downstream.write(string)
    }
    mutating func writeIndent() {
        downstream.write(String(repeating: " ", count: indentLevel * indent))
    }
    mutating func indented(_ body: (inout GenericIndentTextOutputStream) throws -> Void) rethrows {
        indentLevel += 1
        try body(&self)
        indentLevel -= 1
    }
}
