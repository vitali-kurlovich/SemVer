// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-semver",
    platforms: [
        .macOS(.v13),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "SemVer",
            targets: ["SemVer"]
        ),
    ],
    targets: [
        .target(
            name: "SemVer",
            dependencies: []
        ),
        .testTarget(
            name: "SemVerTests",
            dependencies: ["SemVer"]
        ),
    ]
)
