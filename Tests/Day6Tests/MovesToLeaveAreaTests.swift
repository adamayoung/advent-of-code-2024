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

}
