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
    func totalDistanceWhenTwoLocationsAreEqualReturnsZero() async {
        let locations1 = [3]
        let locations2 = [3]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        await #expect(dataset.totalDistance() == 0)
    }

    @Test("totalDistance when 2 locations are 1 apart returns 1")
    func totalDistanceWhenTwoLocationsAreOneApartReturnsOne() async {
        let locations1 = [3]
        let locations2 = [4]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        await #expect(dataset.totalDistance() == 1)
    }

    @Test("totalDistance when 2 locations are 1 apart as minus value returns 1")
    func totalDistanceWhenTwoLocationsAreOneApartAsMinusValueReturnsOne() async {
        let locations1 = [4]
        let locations2 = [3]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        await #expect(dataset.totalDistance() == 1)
    }

    @Test("totalDistance when using test data returns correct result")
    func totalDistanceWhenUsingTestDataReturnsCorrectResult() async {
        let locations1 = [3, 4, 2, 1, 3, 3]
        let locations2 = [4, 3, 5, 3, 9, 3]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        await #expect(dataset.totalDistance() == 11)
    }

    @Test("totalDistance with real input returns correct result")
    func totalDistanceWithRealInputReturnsCorrectResult() async throws {
        let dataset = try await LocationDataset()

        await #expect(dataset.totalDistance() == 2_196_996)
    }

}
