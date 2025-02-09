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
        .package(name: "UIComponents", path: "./UIComponents"),
        .package(name: "CommonKit", path: "./CommonKit")
    ],
    targets: [
        .target(
            name: "FetchCounterModule",
            dependencies: [
                .product(name: "UIComponents", package: "UIComponents"),
                .product(name: "CommonKit", package: "CommonKit")
            ]),
        .testTarget(
              name: "FetchCounterModuleTests",
              dependencies: ["FetchCounterModule"]
          ),
    ]
)
