//
//  ReportDataset.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

final class ReportDataset: Sendable {

    private let reports: [Report]

    init(reports: [Report]) {
        self.reports = reports
    }

    convenience init() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        try await self.init(fileURL: inputFileURL)
    }

    func safeReportsCount() async -> Int {
        reports.count(where: \.isSafe)
    }

    func safeWithProblemDampenerReportsCount() async -> Int {
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
