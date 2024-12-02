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

    init(levels: [Int]) {
        self.levels = levels
    }

}

extension Report {

    private func calcuateIsSafe() -> Bool {
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
