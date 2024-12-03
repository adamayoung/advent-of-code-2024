//
//  TotalDistanceTests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Testing

@testable import Day1

@Suite("Total distance tests")
struct TotalDistanceTests {

    @Test("totalDistance when 2 locations are equal returns 0")
    func totalDistanceWhenTwoLocationsAreEqualReturnsZero() {
        let locations1 = [3]
        let locations2 = [3]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        #expect(dataset.totalDistance() == 0)
    }

    @Test("totalDistance when 2 locations are 1 apart returns 1")
    func totalDistanceWhenTwoLocationsAreOneApartReturnsOne() {
        let locations1 = [3]
        let locations2 = [4]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        #expect(dataset.totalDistance() == 1)
    }

    @Test("totalDistance when 2 locations are 1 apart as minus value returns 1")
    func totalDistanceWhenTwoLocationsAreOneApartAsMinusValueReturnsOne() {
        let locations1 = [4]
        let locations2 = [3]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        #expect(dataset.totalDistance() == 1)
    }

    @Test("totalDistance when using test data returns correct result")
    func totalDistanceWhenUsingTestDataReturnsCorrectResult() {
        let locations1 = [3, 4, 2, 1, 3, 3]
        let locations2 = [4, 3, 5, 3, 9, 3]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        #expect(dataset.totalDistance() == 11)
    }

}
