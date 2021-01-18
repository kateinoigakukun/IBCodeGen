import Foundation
import XCTest

@testable import IBCodeGenKit

final class IBCodeGenKitTests: XCTestCase {
    static let projectPath = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()
    static let xcodeprojPath =
        projectPath
        .appendingPathComponent("TestSuites/TestSuites.xcodeproj")

    static let targetPath =
        projectPath
        .appendingPathComponent("TestSuites/Sources/TestSuites")

    static let destination = ProcessInfo.processInfo.environment["IBCODEGEN_TEST_DESTINATION"] ?? "platform=iOS Simulator,name=iPhone 12 Pro"
    static let scheme = "TestSuites"

    override class func setUp() {
        try! Process.exec(
            bin: "/usr/bin/xcodebuild",
            arguments: [
                "-project", xcodeprojPath.path, "clean",
            ])
    }

    private class func runTest(for testSuite: String = #function) throws {
        guard testSuite.hasPrefix("test") && testSuite.hasSuffix("()") else {
            XCTFail("Invalid testSuite name: \(testSuite)")
            return
        }
        let fileName = testSuite.dropFirst("test".count).dropLast("()".count)
        let generator = IBCodeGenerator()
        let fileManager = FileManager.default
        do {
            let path = targetPath.appendingPathComponent("Generated/\(fileName).generated.swift")
            if !fileManager.fileExists(atPath: path.path) {
                fileManager.createFile(atPath: path.path, contents: nil, attributes: nil)
            }
            var writer = ContentWriter()
            try generator.generate(
                from: targetPath.appendingPathComponent("Resources/\(fileName).xib"),
                target: &writer)
            try writer.content.write(to: path, atomically: true, encoding: .utf8)
        }
        try Process.exec(
            bin: "/usr/bin/xcodebuild",
            arguments: [
                "-project", xcodeprojPath.path, "-scheme", scheme,
                "-destination", destination,
                "-only-testing", "\(scheme)/IBCodeGenKitTests/\(testSuite)",
                "test",
            ])
    }
    func testSimpleView() throws { try Self.runTest() }
    func testAutoresizingMask() throws { try Self.runTest() }
    func testButton() throws { try Self.runTest() }
    func testSubview() throws { try Self.runTest() }
    func testLoadingBarButtonItemView() throws { try Self.runTest() }
    func testDiscoveryProjectCategoryView() throws { try Self.runTest() }
}
