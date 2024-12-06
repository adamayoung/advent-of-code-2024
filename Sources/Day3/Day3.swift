//
//  Day3.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 03/12/2024.
//

import Foundation

///
/// Day 3: Mull It Over
///
@main
struct Day3 {

    static func main() async throws {
        let startTime = Date.now

        let processor = try await CalculationProcessor()
        async let sumOfAllMultiplications = processor.sumOfAllMultiplications()
        async let sumOfAllMultiplicationsWithConditionals =
            processor.sumOfAllMultiplications(withConditionals: true)

        let part1 = await sumOfAllMultiplications
        let part2 = await sumOfAllMultiplicationsWithConditionals

        let timeTaken = startTime.timeIntervalSinceNow * -1 * 1000

        print("Day 3: Mull It Over")
        print("========================\n")
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
        print("\nTime: \(timeTaken)ms")
    }

}
