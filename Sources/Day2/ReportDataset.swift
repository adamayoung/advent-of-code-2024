//
//  ReportDataset.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

final class ReportDataset: Sendable {

    var safeReportsCount: Int {
        calculateSafeReportsCount()
    }

    let reports: [Report]

    init(reports: [Report]) {
        self.reports = reports
    }

    private func calculateSafeReportsCount() -> Int {
        let safeCount = reports.reduce(0) { safeCount, report in
            guard report.isSafe else {
                return safeCount
            }

            return safeCount + 1
        }

        return safeCount
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

        var reports = [Report]()
        for try await line in handle.bytes.lines {
            let levelStrings = line.split(separator: " ")
            let levels = levelStrings.compactMap { Int($0) }

            let report = Report(levels: levels)
            reports.append(report)
        }

        self.init(reports: reports)
    }

}
