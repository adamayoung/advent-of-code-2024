//
//  Day1.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

///
/// Day 1: Historian Hysteria
///
@main
struct Day1 {

    static func main() async throws {
        let startTime = Date.now

        let dataset = try await LocationDataset()
        async let totalDistance = dataset.totalDistance()
        async let similarityScore = dataset.similarityScore()

        let part1 = await totalDistance
        let part2 = await similarityScore

        let timeTaken = startTime.timeIntervalSinceNow * -1 * 1000

        print("Day 1: Historian Hysteria")
        print("=========================\n")
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
        print("\nTime: \(timeTaken)ms")
    }

}
