// swift-tools-version:5.3
import PackageDescription
let package = Package(
    name: "Site",
    products: [
        .executable(name: "Site", targets: ["Site"])
    ],
    dependencies: [
        .package(name: "JavaScriptKit", url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.10.0"),
        .package(name: "IBCodeGenKit", path: "../"),
    ],
    targets: [
        .target(
            name: "Site",
            dependencies: [
                .product(name: "JavaScriptKit", package: "JavaScriptKit"),
                .product(name: "IBCodeGenKit", package: "IBCodeGenKit"),
                .target(name: "POSIXSupport"),
            ],
            linkerSettings: [
                .linkedLibrary("CFXMLInterface"),
                .linkedLibrary("xml2"),
                .unsafeFlags(["-Llib"]),
            ]),
        .target(name: "POSIXSupport"),
    ]
)
