//
//  SimilarityScoreTests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Testing

@testable import Day1

@Suite("Similarity score tests")
struct SimilarityScoreTests {

    @Test("similarityScore when using test data returns correct result")
    func similarityScoreWhenUsingTestDataReturnsCorrectResult() async {
        let locations1 = [3, 4, 2, 1, 3, 3]
        let locations2 = [4, 3, 5, 3, 9, 3]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        await #expect(dataset.similarityScore() == 31)
    }

    @Test("similarityScore with real input returns correct result")
    func similarityScoreWithRealInputReturnsCorrectResult() async throws {
        let dataset = try await LocationDataset()

        await #expect(dataset.similarityScore() == 23_655_822)
    }

}
