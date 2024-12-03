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
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        let dataset = try await ReportDataset(fileURL: inputFileURL)
        let safeReportsCount = dataset.safeReportsCount()
        let safeReportsWithProblemDampenerCount = dataset.safeReportsCount(
            withProblemDampener: true)

        printResults(
            safeReportsCount: safeReportsCount,
            safeReportsWithProblemDampenerCount: safeReportsWithProblemDampenerCount
        )
    }

    private static func printResults(
        safeReportsCount: Int,
        safeReportsWithProblemDampenerCount: Int
    ) {
        print("Day 2: Red-Nosed Reports")
        print("========================\n")
        print("Number of safe reports: \(safeReportsCount)")
        print(
            "Number of safe reports with problem dampener: \(safeReportsWithProblemDampenerCount)"
        )
    }

}
