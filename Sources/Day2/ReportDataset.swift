//
//  ReportDataset.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

final class ReportDataset: Sendable {

    let reports: [Report]

    init(reports: [Report]) {
        self.reports = reports
    }

    func safeReportsCount(withProblemDampener: Bool = false) -> Int {
        if withProblemDampener {
            return safeWithProblemDampenerReportsCount()
        }

        return safeReportsCount()
    }

}

extension ReportDataset {

    private func safeReportsCount() -> Int {
        reports.count(where: \.isSafe)
    }

    private func safeWithProblemDampenerReportsCount() -> Int {
        reports.count(where: \.isSafeWithProblemDampener)
    }

}

extension ReportDataset {

    convenience init(fileURL: URL) async throws {
        guard let handle = try? FileHandle(forReadingFrom: fileURL) else {
            fatalError("cannot open input file")
        }

        defer {
            try? handle.close()
        }

        var reports: [Report] = []
        for try await line in handle.bytes.lines {
            let report = Self.report(from: line)
            reports.append(report)
        }

        self.init(reports: reports)
    }

    private static func report(from line: String) -> Report {
        let levelStrings = line.split(separator: " ")
        let levels = levelStrings.compactMap { Int($0) }

        let report = Report(levels: levels)
        return report
    }

}
