//
//  ReportDataset.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

final class ReportDataset: Sendable {

    var safeReportsCount: Int {
        reports.count(where: \.isSafe)
    }

    var safeReportsWithProblemDampenerCount: Int {
        reports.count(where: \.isSafeWithProblemDampener)
    }

    let reports: [Report]

    init(reports: [Report]) {
        self.reports = reports
    }

}

extension ReportDataset {

    convenience init(fileURL: URL) async throws {
        guard let handle: FileHandle = try? FileHandle(forReadingFrom: fileURL) else {
            fatalError("cannot open input file")
        }

        defer {
            try? handle.close()
        }

        var reports: [Report] = []
        for try await line in handle.bytes.lines {
            let levelStrings = line.split(separator: " ")
            let levels = levelStrings.compactMap { Int($0) }

            let report = Report(levels: levels)
            reports.append(report)
        }

        self.init(reports: reports)
    }

}
