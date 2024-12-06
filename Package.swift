// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "advent-of-code-2024",

    platforms: [.macOS(.v15)],

    products: [
        .executable(name: "Day1", targets: ["Day1"]),
        .executable(name: "Day2", targets: ["Day2"]),
        .executable(name: "Day3", targets: ["Day3"]),
        .executable(name: "Day4", targets: ["Day4"]),
        .executable(name: "Day5", targets: ["Day5"]),
        .executable(name: "Day6", targets: ["Day6"]),
        .executable(name: "Day7", targets: ["Day7"])
    ],

    targets: [
        .executableTarget(name: "Day1", resources: [.process("Resources")]),
        .testTarget(name: "Day1Tests", dependencies: ["Day1"]),

        .executableTarget(name: "Day2", resources: [.process("Resources")]),
        .testTarget(name: "Day2Tests", dependencies: ["Day2"]),

        .executableTarget(name: "Day3", resources: [.process("Resources")]),
        .testTarget(name: "Day3Tests", dependencies: ["Day3"]),

        .executableTarget(name: "Day4", resources: [.process("Resources")]),
        .testTarget(name: "Day4Tests", dependencies: ["Day4"]),

        .executableTarget(name: "Day5", resources: [.process("Resources")]),
        .testTarget(name: "Day5Tests", dependencies: ["Day5"]),

        .executableTarget(name: "Day6", resources: [.process("Resources")]),
        .testTarget(name: "Day6Tests", dependencies: ["Day6"]),

        .executableTarget(name: "Day7", resources: [.process("Resources")]),
        .testTarget(name: "Day7Tests", dependencies: ["Day7"])
    ]
)
