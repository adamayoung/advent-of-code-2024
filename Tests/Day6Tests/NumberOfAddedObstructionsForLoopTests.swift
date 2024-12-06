//
//  NumberOfAddedObstructionsForLoopTests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 06/12/2024.
//

import Foundation
import Testing

@testable import Day6

@Suite("Number of added obstructions for loop tests")
struct NumberOfAddedObstructionsForLoopTests {

    @Test("numberOfAddedObstructionsForLoop when using test data returns correct result")
    func numberOfAddedObstructionsForLoopWhenUsingTestDataReturnsCorrectResult() async {
        let patrolMap = PatrolMap(
            squares: [
                [
                    .empty, .empty, .empty, .empty, .obstruction, .empty, .empty, .empty, .empty,
                    .empty
                ],
                [
                    .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty,
                    .obstruction
                ],
                [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
                [
                    .empty, .empty, .obstruction, .empty, .empty, .empty, .empty, .empty, .empty,
                    .empty
                ],
                [
                    .empty, .empty, .empty, .empty, .empty, .empty, .empty, .obstruction, .empty,
                    .empty
                ],
                [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
                [
                    .empty, .obstruction, .empty, .empty, .labGuard(.north), .empty, .empty, .empty,
                    .empty, .empty
                ],
                [
                    .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .obstruction,
                    .empty
                ],
                [
                    .obstruction, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty,
                    .empty
                ],
                [
                    .empty, .empty, .empty, .empty, .empty, .empty, .obstruction, .empty, .empty,
                    .empty
                ]
            ]
        )

        await #expect(patrolMap.numberOfAddedObstructionsForLoop() == 6)
    }

    @Test("numberOfAddedObstructionsForLoop with real input returns correct result")
    func numberOfDistinctPositionsToLeaveMapWithRealInputReturnsCorrectResult() async throws {
        let patrolMap = try await PatrolMap()

        await #expect(patrolMap.numberOfAddedObstructionsForLoop() == 1957)
    }

}
