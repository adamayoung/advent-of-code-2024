//
//  Day6Tests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 06/12/2024.
//

import Foundation
import Testing

@testable import Day6

@Suite("Moves to leave area tests")
struct MovesToLeaveAreaTests {

    @Test("guardStartingPositionReturnsCorrectValue")
    func guardStartingPositionReturnsCorrectValue() {
        let patrolMap = PatrolMap(
            squares: [
                [.empty, .empty, .empty],
                [.empty, .labGuard(.north), .empty],
                [.empty, .empty, .empty]
            ]
        )

        #expect(patrolMap.guardStartingCoordinate == Coordinate(row: 1, column: 1))
    }

    @Test("numberOfDistinctPositionsToLeaveMap when using test data returns correct result")
    func numberOfDistinctPositionsToLeaveMapWhenUsingTestDataReturnsCorrectResult() {
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

        #expect(patrolMap.numberOfDistinctPositionsToLeaveMap() == 41)
    }

    @Test("numberOfDistinctPositionsToLeaveMap when infinite loop 1 returns zero")
    func numberOfAddedObstructionsForLoopWhenInfiniteLoop1ReturnsCorrectResult() async {
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
                    .empty, .obstruction, .empty, .obstruction, .labGuard(.north), .empty, .empty,
                    .empty,
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

        #expect(patrolMap.numberOfDistinctPositionsToLeaveMap() == 0)
    }

    @Test("numberOfDistinctPositionsToLeaveMap when infinite loop 2 returns zero")
    func numberOfAddedObstructionsForLoopWhenInfiniteLoop2ReturnsCorrectResult() async {
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
                    .empty, .empty, .empty, .empty, .empty, .empty, .obstruction, .obstruction,
                    .empty,
                    .empty
                ]
            ]
        )

        #expect(patrolMap.numberOfDistinctPositionsToLeaveMap() == 0)
    }

    @Test("numberOfDistinctPositionsToLeaveMap with real input returns correct result")
    func numberOfDistinctPositionsToLeaveMapWithRealInputReturnsCorrectResult() async throws {
        let patrolMap = try await PatrolMap()

        #expect(patrolMap.numberOfDistinctPositionsToLeaveMap() == 5269)
    }

}
