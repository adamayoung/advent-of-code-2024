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
        let safeReportsCount = dataset.safeReportsCount()
        let safeReportsWithProblemDampenerCount = dataset.safeWithProblemDampenerReportsCount()

        let timeTaken = startTime.timeIntervalSinceNow * -1 * 1000

        print("Day 2: Red-Nosed Reports")
        print("========================\n")
        print("Part 1: \(safeReportsCount)")
        print("Part 2: \(safeReportsWithProblemDampenerCount)")
        print("\nTime: \(timeTaken)ms")
    }

}
