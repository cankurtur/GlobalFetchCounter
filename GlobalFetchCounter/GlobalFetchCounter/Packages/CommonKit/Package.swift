// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonKit",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CommonKit",
            targets: ["CommonKit"]),
    ],
    dependencies: [
      .package(url: "https://github.com/cankurtur-global/GlobalNetworking", from: "4.2.1")
    ],
    targets: [
        .target(
          name: "CommonKit",
          dependencies: [
            .product(name: "GlobalNetworking", package: "GlobalNetworking")
          ],
          resources: [
            .process("Resources/Config.plist")
          ]
        ),
    ]
)
