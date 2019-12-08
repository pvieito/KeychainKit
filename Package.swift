// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "KeychainKit",
    platforms: [
        .macOS(.v10_15)
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
        .package(path: "../LoggerKit"),
        .package(path: "../AuthenticationKit"),
        .package(path: "../CodeSignKit")
    ],
    targets: [
        .target(
            name: "KeychainTool",
            dependencies: ["LoggerKit", "CommandLineKit", "FoundationKit", "KeychainKit", "AuthenticationKit", "CodeSignKit"],
            path: "KeychainTool"
        ),
        .target(
            name: "KeychainKit",
            dependencies: ["FoundationKit", "LoggerKit"],
            path: "KeychainKit"
        )
    ]
)
