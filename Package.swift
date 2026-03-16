// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-semver",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .watchOS(.v9),
        .tvOS(.v16),
    ],
    products: [
        .library(
            name: "SemanticVersioning",
            targets: ["SemanticVersioning"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "SemanticVersioning",
            dependencies: []
        ),
        .testTarget(
            name: "SemanticVersioningTests",
            dependencies: ["SemanticVersioning"]
        ),
    ]
)
