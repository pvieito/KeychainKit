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
        .package(url: "https://github.com/pvieito/FoundationKit.git", .branch("master")),
        .package(url: "https://github.com/pvieito/LoggerKit.git", .branch("master")),
        .package(url: "https://github.com/pvieito/CommandLineKit.git", .branch("master")),
        .package(url: "https://github.com/pvieito/CodeSignKit.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "KeychainTool",
            dependencies: ["LoggerKit", "CommandLineKit", "FoundationKit", "KeychainKit", "CodeSignKit"],
            path: "KeychainTool"
        ),
        .target(
            name: "KeychainKit",
            dependencies: ["FoundationKit", "LoggerKit"],
            path: "KeychainKit"
        )
    ]
)
