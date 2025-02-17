// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ComponentKit",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ComponentKit",
            targets: ["ComponentKit"]),
    ],
    targets: [
        .target(
            name: "ComponentKit",
            resources: [.process("Resources")]),
    ]
)
