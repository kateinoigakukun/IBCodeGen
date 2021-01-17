protocol IndentTextOutputStream {
    mutating func writeLine(_ line: String)
    mutating func writeLine(_ line: (inout Self) -> Void)
    mutating func write(_ string: String)
    mutating func writeIndent()
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

    mutating func writeLine(_ line: (inout Self) -> Void) {
        downstream.write(String(repeating: " ", count: indentLevel * indent))
        line(&self)
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
    mutating func indented(_ body: (inout GenericIndentTextOutputStream) -> Void) {
        indentLevel += 1
        body(&self)
        indentLevel -= 1
    }
}
