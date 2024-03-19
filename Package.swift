// swift-tools-version:5.9

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
        .package(url: "git@github.com:pvieito/FoundationKit.git", branch: "master"),
        .package(url: "git@github.com:pvieito/LoggerKit.git",  branch: "master"),
        .package(url: "git@github.com:pvieito/CodeSignKit.git",  branch: "master"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
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
