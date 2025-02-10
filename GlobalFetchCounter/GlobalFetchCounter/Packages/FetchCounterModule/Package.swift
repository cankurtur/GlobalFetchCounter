// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FetchCounterModule",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "FetchCounterModule",
            targets: ["FetchCounterModule"]),
    ],
    dependencies: [
        .package(name: "ComponentKit", path: "./ComponentKit"),
        .package(name: "CommonKit", path: "./CommonKit"),
        .package(name: "ConfigKit", path: "./ConfigKit")
    ],
    targets: [
        .target(
            name: "FetchCounterModule",
            dependencies: [
                .product(name: "ComponentKit", package: "ComponentKit"),
                .product(name: "CommonKit", package: "CommonKit"),
                .product(name: "ConfigKit", package: "ConfigKit")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
              name: "FetchCounterModuleTests",
              dependencies: ["FetchCounterModule"]
          ),
    ]
)
