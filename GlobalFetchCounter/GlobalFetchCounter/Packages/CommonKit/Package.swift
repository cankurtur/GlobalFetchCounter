// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonKit",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CommonKit",
            targets: ["CommonKit"]),
    ],
    dependencies: [
      .package(url: "https://github.com/cankurtur-global/GlobalNetworking", from: "4.2.1"),
      .package(name: "ConfigKit", path: "./ConfigKit")
    ],
    targets: [
        .target(
          name: "CommonKit",
          dependencies: [
            .product(name: "GlobalNetworking", package: "GlobalNetworking"),
            .product(name: "ConfigKit", package: "ConfigKit")
          ]
        ),
    ]
)
