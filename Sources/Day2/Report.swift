//
//  Report.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

struct Report: Sendable {

    let levels: [Int]

    var isSafe: Bool {
        calculateIsSafe()
    }

    var isSafeWithProblemDampener: Bool {
        calculateIsSafeWithProblemDampener()
    }

    init(levels: [Int]) {
        self.levels = levels
    }

}

extension Report {

    private func calculateIsSafe() -> Bool {
        Self.isSafe(levels: levels)
    }

    private func calculateIsSafeWithProblemDampener() -> Bool {
        if Self.isSafe(levels: levels) {
            return true
        }

        for index in 0..<levels.count {
            var dampenerLevels = levels
            dampenerLevels.remove(at: index)
            if Self.isSafe(levels: dampenerLevels) {
                return true
            }
        }

        return false
    }

}

extension Report {

    private static let safeRange = 1...3

    private static func isSafe(levels: [Int]) -> Bool {
        guard levels.count > 1 else {
            return true
        }

        let isIncreasing = levels[0] < levels[1]
        for (index, level) in levels.enumerated() where index > 0 {
            if isIncreasing, level < levels[index - 1] {
                return false
            }

            if !isIncreasing, level > levels[index - 1] {
                return false
            }

            let difference = abs(level - levels[index - 1])
            guard safeRange.contains(difference) else {
                return false
            }
        }

        return true
    }

}
