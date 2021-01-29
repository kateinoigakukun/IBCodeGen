// swift-tools-version:5.3
import PackageDescription
let package = Package(
    name: "Site",
    products: [
        .executable(name: "Site", targets: ["Site"])
    ],
    dependencies: [
        .package(name: "JavaScriptKit", url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.10.0"),
        .package(name: "IBCodeGen", path: "../"),
    ],
    targets: [
        .target(
            name: "Site",
            dependencies: [
                .product(name: "JavaScriptKit", package: "JavaScriptKit"),
                .product(name: "IBCodeGenKit", package: "IBCodeGen"),
                .target(name: "POSIXSupport"),
            ],
            linkerSettings: [
                .linkedLibrary("xml2"),
                .unsafeFlags(["-Llib"]),
            ]),
        .target(name: "POSIXSupport"),
    ]
)
