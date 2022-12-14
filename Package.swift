// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "advent-of-code",
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0")
    ],
    targets: [
        .target(
            name: "advent-of-code",
            dependencies: [
              .product(name: "Algorithms", package: "swift-algorithms"),
              .product(name: "Collections", package: "swift-collections"),
              .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            resources: [.copy("Resources")]
         ),
        .testTarget(
            name: "advent-of-codeTests",
            dependencies: ["advent-of-code"]),
    ]
)
