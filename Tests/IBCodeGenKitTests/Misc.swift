import Foundation

extension Process {
    enum ProcessError: Error, CustomStringConvertible {
        case nonZeroExit(
            TerminationReason, Int32, command: String
        )
        
        public var description: String {
            switch self {
            case let .nonZeroExit(_, code, command):
                return """
                    <ProcessError.nonZeroExit: command: \(command), exit: \(code)>
                    """
            }
        }
    }

    static func exec(bin: String, arguments: [String], cwd: String? = nil) throws {
        let process = Process()
        process.launchPath = bin
        process.arguments = arguments
        if let cwd = cwd {
            process.currentDirectoryPath = cwd
        }

        process.launch()
        process.waitUntilExit()

        if process.terminationReason != .exit || process.terminationStatus != 0 {
            throw ProcessError.nonZeroExit(
                process.terminationReason, process.terminationStatus,
                command: ([bin] + arguments).joined(separator: " ")
            )
        }
    }
}

extension FileHandle: TextOutputStream {
    public func write(_ string: String) {
        write(Data(string.utf8))
    }
}

