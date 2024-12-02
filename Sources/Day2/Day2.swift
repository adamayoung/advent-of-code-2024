//
//  Day2.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

///
/// Day 1: Red-Nosed Reports
///
@main
struct Day2 {

    static func main() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt") else {
            fatalError("input file missing")
        }

        let datset = try await ReportDataset(fileURL: inputFileURL)
        let safeReportsCount = datset.safeReportsCount
        let safeReportsWithProblemDampenerCount = datset.safeReportsWithProblemDampenerCount

        print("Number of Safe reports: \(safeReportsCount)")
        print("Number of Safe reports with problem dampener: \(safeReportsWithProblemDampenerCount)")
    }

}
