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
        .package(url: "git@github.com:pvieito/FoundationKit.git", .branch("master")),
        .package(url: "git@github.com:pvieito/LoggerKit.git", .branch("master")),
        .package(url: "git@github.com:pvieito/CodeSignKit.git", .branch("master")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.0.1")),
    ],
    targets: [
        .target(
            name: "KeychainTool",
            dependencies: ["LoggerKit", "FoundationKit", "KeychainKit", "CodeSignKit", .product(name: "ArgumentParser", package: "swift-argument-parser")],
            path: "KeychainTool"
        ),
        .target(
            name: "KeychainKit",
            dependencies: ["FoundationKit", "LoggerKit"],
            path: "KeychainKit"
        )
    ]
)
