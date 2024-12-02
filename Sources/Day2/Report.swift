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
        calcuateIsSafe()
    }

    var isSafeWithProblemDampener: Bool {
        calcuateIsSafeWithProblemDampener()
    }

    init(levels: [Int]) {
        self.levels = levels
    }

}

extension Report {

    private func calcuateIsSafe() -> Bool {
        Self.isSafe(levels: levels)
    }

    private func calcuateIsSafeWithProblemDampener() -> Bool {
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

    private static func isSafe(levels: [Int]) -> Bool {
        let isIncreasing = levels[0] < levels[1]
        for (index, level) in levels.enumerated() where index > 0 {
            if isIncreasing, level < levels[index - 1] {
                return false
            }

            if !isIncreasing, level > levels[index - 1] {
                return false
            }

            let difference = abs(level - levels[index - 1])
            guard difference >= 1, difference <= 3 else {
                return false
            }
        }

        return true
    }

}
