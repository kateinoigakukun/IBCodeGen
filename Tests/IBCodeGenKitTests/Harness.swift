import Foundation
import XCTest

@testable import IBCodeGenKit
import IBDecodable

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
        .appendingPathComponent("TestSuites/Sources/Views")

    static let destination = ProcessInfo.processInfo.environment["IBCODEGEN_TEST_DESTINATION"] ?? "platform=iOS Simulator,name=iPhone 12 Pro"
    static let onlyCodeGen = ProcessInfo.processInfo.environment["IBCODEGEN_TEST_ONLY_CODEGEN"] != nil
    static let scheme = "TestSuites"

    override class func setUp() {
        guard !onlyCodeGen else { return }
        try! Process.exec(
            bin: "/usr/bin/xcodebuild",
            arguments: [
                "-project", xcodeprojPath.path, "clean",
            ])
    }

    private class func buildOptions(excludes: [String] = [], only: String? = nil, xibPath: URL) throws -> IBCodeGenerator.Options {
        var options = IBCodeGenerator.Options()
        options.excludedRootViews = excludes
        if let only = only {
            let viewIds = try XibFile(url: xibPath).document.views?
                .compactMap { $0.view as? IBIdentifiable }
                .map(\.id) ?? []
            options.excludedRootViews = viewIds.filter { $0 != only }
        }
        return options
    }

    private class func buildOptions(excludes: [String] = [], only: String? = nil, testSuite: String = #function) throws -> IBCodeGenerator.Options {
        let xibPath = targetPath.appendingPathComponent("Resources/\(Self.fileName(testSuite: testSuite)).xib")
        return try Self.buildOptions(excludes: excludes, only: only, xibPath: xibPath)
    }

    private class func fileName(testSuite: String) -> String {
        guard testSuite.hasPrefix("test") && testSuite.hasSuffix("()") else {
            fatalError("Invalid testSuite name: \(testSuite)")
        }
        return String(testSuite.dropFirst("test".count).dropLast("()".count))
    }

    private class func runTest(options: IBCodeGenerator.Options? = nil, testSuite: String = #function) throws {
        let fileName = self.fileName(testSuite: testSuite)
        let generator = IBCodeGenerator()
        let fileManager = FileManager.default

        let path = targetPath.appendingPathComponent("Generated/\(fileName).generated.swift")
        if !fileManager.fileExists(atPath: path.path) {
            fileManager.createFile(atPath: path.path, contents: nil, attributes: nil)
        }
        let xibPath = targetPath.appendingPathComponent("Resources/\(fileName).xib")
        let options = try options ?? buildOptions(testSuite: testSuite)
        var writer = ContentWriter()
        let result = try generator.generate(from: xibPath, options: options, target: &writer)
        let views = "[" + result.classNames.map { name in
            guard let name = name else { return "nil" }
            if options.classTemplate == .customView {
                return "\(name)()"
            } else {
                return "\(name)().contentView"
            }
        }.joined(separator: ", ") + "]"
        
        writer.write("""

            func make\(fileName)Views() -> [UIView?] {
                \(views)
            }

            """)
        try writer.content.write(to: path, atomically: true, encoding: .utf8)

        guard !onlyCodeGen else { return }
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
    func testButton() throws {
        // Exclude size class related views
        try Self.runTest(options: Self.buildOptions(excludes: ["6nx-GC-s3f", "hxo-wv-kpq", "bhv-xe-538"]))
    }
    func testLabel() throws {
        // Exclude minimumFontSize and adjustsLetterSpacingToFitWidth related views
        try Self.runTest(options: Self.buildOptions(excludes: ["R5g-7B-50Y", "QJM-ND-fWW"]))
    }
    func testImageView() throws { try Self.runTest() }
    func testSimulatedMetrics() throws {
        // Exclude Opaque Navigation|Tab|Tool Bar and Modal Sheet related views
        try Self.runTest(options: Self.buildOptions(excludes: [
            "Nzv-CW-QKi", "TMF-cQ-ANF", "kay-jc-eiq", "Q8g-cr-4Ad",
            "9Ag-lF-s1d", "2Md-Kf-K3o", "eTt-Sc-Fzi", "2WY-wc-VGC",
            "A2l-RL-YAK", "jCR-Mx-M8z",
        ]))
    }
    func testView() throws {
        // Exclude contentStretch related views
        try Self.runTest(options: Self.buildOptions(excludes: ["6aX-RF-FLC"]))
    }
    func testStackView() throws { try Self.runTest() }
    func testCustomRootClass() throws {
        var options = try Self.buildOptions()
        options.classTemplate = .customView
        try Self.runTest(options: options)
    }
    // func testTableViewCell() throws { try Self.runTest() }
    func testLayoutConstraint() throws { try Self.runTest() }
    func testSubview() throws { try Self.runTest() }
    func testLoadingBarButtonItemView() throws { try Self.runTest() }
    func testDiscoveryProjectCategoryView() throws { try Self.runTest() }
    func testPaymentMethodsFooterView() throws { try Self.runTest() }
}
