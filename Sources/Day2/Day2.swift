//
//  Day2.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

///
/// Day 2: Red-Nosed Reports
///
@main
struct Day2 {

    static func main() async throws {
        let startTime = Date.now

        let dataset = try await ReportDataset()
        async let safeReportsCount = dataset.safeReportsCount()
        async let safeReportsWithProblemDampenerCount = dataset.safeWithProblemDampenerReportsCount()

        let part1 = await safeReportsCount
        let part2 = await safeReportsWithProblemDampenerCount

        let timeTaken = startTime.timeIntervalSinceNow * -1 * 1000

        print("Day 2: Red-Nosed Reports")
        print("========================\n")
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
        print("\nTime: \(timeTaken)ms")
    }

}
