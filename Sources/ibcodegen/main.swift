import IBCodeGenKit
import ArgumentParser
import Foundation

class ContentWriter: TextOutputStream {
    private(set) var content: String = ""
    func write(_ string: String) {
        content += string
    }
}


struct IBCodeGenTool: ParsableCommand {
    @Argument(transform: URL.init(fileURLWithPath: ))
    var input: URL

    @Option(name: .short, transform: URL.init(fileURLWithPath: ))
    var output: URL

    func run() throws {
        let generator = IBCodeGenerator()
        var writer = ContentWriter()
        let xmlContent = try String(contentsOf: input)
        _ = try generator.generate(
            from: xmlContent,
            fileBaseName: input.deletingPathExtension().lastPathComponent,
            target: &writer)
        try writer.content.write(to: output, atomically: true, encoding: .utf8)
    }
}

IBCodeGenTool.main()
