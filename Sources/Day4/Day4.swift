//
//  Day4.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 04/12/2024.
//

import Foundation

///
/// Day 4: Ceres Search
///
@main
struct Day4 {

    static func main() async throws {
        let startTime = Date.now

        let wordsearch = try await Wordsearch()
        async let numberOfXmasOccurrences = wordsearch.numberOfXMASOccurrences()
        async let numberOfXxMasOccurrences = wordsearch.numberOfXxMASOccurrences()

        let part1 = await numberOfXmasOccurrences
        let part2 = await numberOfXxMasOccurrences

        let timeTaken = startTime.timeIntervalSinceNow * -1 * 1000

        print("Day 4: Ceres Search")
        print("========================\n")
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
        print("\nTime: \(timeTaken)ms")
    }

}
