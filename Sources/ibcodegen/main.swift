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
    static let configuration = CommandConfiguration(
        commandName: "ibcodegen", abstract: "Translate .xib or .storyboard into Swift"
    )
    @Argument(help: "An input .xib or .storyboard", transform: URL.init(fileURLWithPath: ))
    var input: URL

    @Option(name: .shortAndLong, help: "Write to file", transform: URL.init(fileURLWithPath: ))
    var output: URL?

    func run() throws {
        let generator = IBCodeGenerator()
        var writer = ContentWriter()
        let xmlContent = try String(contentsOf: input)
        _ = try generator.generate(
            from: xmlContent,
            fileBaseName: input.deletingPathExtension().lastPathComponent,
            target: &writer)
        if let output = output {
            try writer.content.write(to: output, atomically: true, encoding: .utf8)
        } else {
            print(writer.content)
        }
    }
}

IBCodeGenTool.main()
