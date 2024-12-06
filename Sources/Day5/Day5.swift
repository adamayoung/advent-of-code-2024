//
//  Day5.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 05/12/2024.
//

import Foundation

///
/// Day 5: Print Queue
///
@main
struct Day5 {

    static func main() async throws {
        let startTime = Date.now

        let printerInstructions = try await PrinterInstructions()
        async let sumOfMiddlePagesForCorrectlyOrderedUpdates = printerInstructions
            .sumOfMiddlePagesForCorrectlyOrderedUpdates()

        async let sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrdering = printerInstructions
            .sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrdering()

        let part1 = await sumOfMiddlePagesForCorrectlyOrderedUpdates
        let part2 = await sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrdering

        let timeTaken = startTime.timeIntervalSinceNow * -1 * 1000

        print("Day 5: Print Queue")
        print("========================\n")
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
        print("\nTime: \(timeTaken)ms")
    }

}
