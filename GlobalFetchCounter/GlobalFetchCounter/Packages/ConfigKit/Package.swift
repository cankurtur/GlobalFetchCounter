// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConfigKit",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ConfigKit",
            targets: ["ConfigKit"]),
    ],
    targets: [
        .target(
          name: "ConfigKit",
          resources: [
            .process("Resources/Config.plist")
          ]
        ),
    ]
)
