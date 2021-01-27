// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IBCodeGenKit",
    platforms: [.macOS(.v10_10)],
    products: [
        .executable(
            name: "ibcodegen",
            targets: ["ibcodegen"]),
        .library(name: "IBCodeGenKit", targets: ["IBCodeGenKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kateinoigakukun/IBDecodable.git", .branch("ibcodegen")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.3.0")),
    ],
    targets: [
        .target(name: "ibcodegen", dependencies: [
            .target(name: "IBCodeGenKit"),
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
        ]),
        .target(
            name: "IBCodeGenKit",
            dependencies: [
                "IBDecodable"
            ]),
        .testTarget(
            name: "IBCodeGenKitTests",
            dependencies: ["IBCodeGenKit"]),
    ]
)
