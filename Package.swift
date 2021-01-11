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
    ],
    dependencies: [
        .package(url: "https://github.com/kateinoigakukun/IBDecodable.git", .branch("ibcodegen")),
    ],
    targets: [
        .target(
            name: "ibcodegen",
            dependencies: ["IBCodeGenKit"]),
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
