// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "advent-of-code",
  platforms: [
    .macOS(.v14),
    .custom("linux", versionString: "5.3")
  ],
  products: [
    .library(name: "advent-of-code", targets: ["advent-of-code"]),
  ],
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
      resources: [.process("Resources")]
    ),
    .executableTarget(
      name: "executable",
      dependencies: [
        "advent-of-code"
      ]
    ),
    .testTarget(name: "advent-of-code-tests", dependencies: ["advent-of-code"]),
  ]
)
for target in package.targets {
  target.swiftSettings = target.swiftSettings ?? []
  target.swiftSettings?.append(
    .unsafeFlags([
      "-Xfrontend", "-warn-concurrency",
      "-Xfrontend", "-enable-actor-data-race-checks",
      "-enable-bare-slash-regex",
    ])
  )
}
