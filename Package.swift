// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "advent-of-code-2024",

    platforms: [.macOS(.v14)],

    products: [
        .executable(name: "Day1", targets: ["Day1"]),
        .executable(name: "Day2", targets: ["Day2"])
    ],

    targets: [
        .executableTarget(name: "Day1", resources: [.process("Resources")]),
        .testTarget(name: "Day1Tests", dependencies: ["Day1"]),

        .executableTarget(name: "Day2", resources: [.process("Resources")]),
        .testTarget(name: "Day2Tests", dependencies: ["Day2"])
    ]
)
