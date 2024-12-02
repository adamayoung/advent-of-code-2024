//
//  Day1Tests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Testing

@testable import Day1

@Suite
struct Day1Tests {

    @Test
    func totalDistanceWithTestDataReturnsCorrectResult() {
        let locations1 = [3, 4, 2, 1, 3, 3]
        let locations2 = [4, 3, 5, 3, 9, 3]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        #expect(dataset.totalDistance == 11)
    }

    @Test
    func similarityScoreWithTestDataReturnsCorrectResult() {
        let locations1 = [3, 4, 2, 1, 3, 3]
        let locations2 = [4, 3, 5, 3, 9, 3]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        #expect(dataset.similarityScore == 31)
    }

}
