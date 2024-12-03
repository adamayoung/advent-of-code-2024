//
//  SafeWithProblemDampenerReportTests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Testing

@testable import Day2

@Suite("Safe with problem dampener report tests")
struct SafeWithProblemDampenerReportTests {

    @Test("reportIsSafeWithProblemDampener when levels are safe returns true")
    func reportIsSafeWithProblemDampenerWhenLevelsAreSafeReturnsTrue() {
        let report = Report(levels: [7, 6, 4, 2, 1])

        #expect(report.isSafeWithProblemDampener)
    }

    @Test(
        "reportIsSafeWithProblemDampener when levels are unsafe with any level removed returns false"
    )
    func reportIsSafeWithProblemDampenerWhenLevelsAreUnsafeWithAnyLevelRemovedReturnsFalse() {
        let report = Report(levels: [1, 2, 7, 8, 9])

        #expect(!report.isSafeWithProblemDampener)
    }

    @Test(
        "reportIsSafeWithProblemDampener when levels are unsafe with one level removed returns true"
    )
    func reportIsSafeWithProblemDampenerWhenLevelsAreUnsafeWithOneLevelRemovedReturnsTrue() {
        let report = Report(levels: [1, 3, 2, 4, 5])

        #expect(report.isSafeWithProblemDampener)
    }

    @Test("safeReportsWithproblemDampenerCount when using test data returns correct result")
    func safeReportsWithProblemDampenerCountWhenUsingTestDataReturnsCorrectResult() {
        let reports = [
            Report(levels: [7, 6, 4, 2, 1]),
            Report(levels: [1, 2, 7, 8, 9]),
            Report(levels: [9, 7, 6, 2, 1]),
            Report(levels: [1, 3, 2, 4, 5]),
            Report(levels: [8, 6, 4, 4, 1]),
            Report(levels: [1, 3, 6, 7, 9])
        ]

        let dataset = ReportDataset(reports: reports)

        #expect(dataset.safeReportsCount(withProblemDampener: true) == 4)
    }

}
