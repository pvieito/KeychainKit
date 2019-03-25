// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "KeychainKit",
    platforms: [
        .macOS(.v10_12)
    ],
    products: [
        .executable(
            name: "KeychainTool",
            targets: ["KeychainTool"]
        ),
        .library(
            name: "KeychainKit",
            targets: ["KeychainKit"]
        )
    ],
    dependencies: [
        .package(path: "../FoundationKit"),
        .package(path: "../CommandLineKit"),
        .package(path: "../LoggerKit")
    ],
    targets: [
        .target(
            name: "KeychainTool",
            dependencies: ["LoggerKit", "CommandLineKit", "FoundationKit", "KeychainKit"],
            path: "KeychainTool"
        ),
        .target(
            name: "KeychainKit",
            dependencies: ["FoundationKit", "LoggerKit"],
            path: "KeychainKit"
        )
    ]
)
