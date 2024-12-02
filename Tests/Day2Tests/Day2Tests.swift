//
//  Day2Tests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Testing
@testable import Day2

@Suite
struct Day2Tests {

    @Test
    func reportIsSafeWhenSafeReturnsTrue() {
        let report = Report(levels: [7, 6, 4, 2, 1])

        #expect(report.isSafe)
    }

    @Test
    func reportIsSafeWhenUnsafeReturnsFalse() {
        let report = Report(levels: [1, 2, 7, 8, 9])

        #expect(!report.isSafe)
    }

    @Test
    func safeReportsCountWithTestDataReturnsCorrectResult() {
        let reports = [
            Report(levels: [7, 6, 4, 2, 1]),
            Report(levels: [1, 2, 7, 8, 9]),
            Report(levels: [9, 7, 6, 2, 1]),
            Report(levels: [1, 3, 2, 4, 5]),
            Report(levels: [8, 6, 4, 4, 1]),
            Report(levels: [1, 3, 6, 7, 9])
        ]

        let dataset = ReportDataset(reports: reports)

        #expect(dataset.safeReportsCount == 2)
    }

}
