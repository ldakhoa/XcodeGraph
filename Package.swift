// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XcodeGraph",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "xcodegraph",
            targets: ["xcodegraph"]),
        .library(
            name: "XcodeGraphKit",
            targets: ["XcodeGraphKit"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            .upToNextMinor(from: "1.1.4")),
        .package(
            url: "https://github.com/apple/swift-log.git",
            .upToNextMinor(from: "1.4.2")),
        .package(
            url: "https://github.com/onevcat/Rainbow",
            .upToNextMinor(from: "4.0.1")),
    ],
    targets: [
        .executableTarget(
            name: "xcodegraph",
            dependencies: [
                .target(name: "XcodeGraphKit"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .target(
            name: "XcodeGraphKit",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Rainbow", package: "Rainbow"),
            ]
        ),
        .testTarget(
            name: "XcodeGraphKitTests",
            dependencies: ["XcodeGraphKit"]),
    ]
)
