//
//  Day6.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 06/12/2024.
//

import Foundation

///
/// Day 6: Guard Gallivant
///
@main
struct Day6 {

    static func main() async throws {
        let startTime = Date.now

        let patrolMap = try await PatrolMap()
        let numberOfDistinctPositionsToLeaveMap = patrolMap.numberOfDistinctPositionsToLeaveMap()
        let numberOfAddedObstructionsForLoop = await patrolMap.numberOfAddedObstructionsForLoop()

        let timeTaken = startTime.timeIntervalSinceNow * -1 * 1000

        print("Day 6: Guard Gallivant")
        print("========================\n")
        print("Part 1: \(numberOfDistinctPositionsToLeaveMap)")
        print("Part 2: \(numberOfAddedObstructionsForLoop)")
        print("\nTime: \(timeTaken)ms")
    }

}
