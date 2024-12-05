//
//  SumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrderingTests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 05/12/2024.
//

import Foundation
import Testing

@testable import Day5

@Suite("Sum of middle pages for incorrectly ordered updates after ordering tests")
struct SumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrderingTests {

    @Test(
        "sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrdering when using simple test data returns correct result"
    )
    func sumOfMiddlePagesForCorrectlyOrderedUpdatesWhenUsingSimpleTestData1ReturnsCorrectResult()
        async
    {
        let printerInstructions = PrinterInstructions(
            pageOrderingRules: [
                (47, 53),
                (97, 13),
                (97, 61),
                (97, 47),
                (75, 29),
                (61, 13),
                (75, 53),
                (29, 13),
                (97, 29),
                (53, 29),
                (61, 53),
                (97, 53),
                (61, 29),
                (47, 13),
                (75, 47),
                (97, 75),
                (47, 61),
                (75, 61),
                (47, 29),
                (75, 13),
                (53, 13)
            ],
            pagesToProduceInUpdates: [
                [97, 13, 75, 29, 47]
            ]
        )

        await #expect(
            printerInstructions.sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrdering() == 47
        )
    }

    @Test(
        "sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrdering when using test data 1 returns correct result"
    )
    func sumOfMiddlePagesForCorrectlyOrderedUpdatesWhenUsingTestData1ReturnsCorrectResult() async {
        let printerInstructions = PrinterInstructions(
            pageOrderingRules: [
                (47, 53),
                (97, 13),
                (97, 61),
                (97, 47),
                (75, 29),
                (61, 13),
                (75, 53),
                (29, 13),
                (97, 29),
                (53, 29),
                (61, 53),
                (97, 53),
                (61, 29),
                (47, 13),
                (75, 47),
                (97, 75),
                (47, 61),
                (75, 61),
                (47, 29),
                (75, 13),
                (53, 13)
            ],
            pagesToProduceInUpdates: [
                [75, 47, 61, 53, 29],
                [97, 61, 53, 29, 13],
                [75, 29, 13],
                [75, 97, 47, 61, 53],
                [61, 13, 29],
                [97, 13, 75, 29, 47]
            ]
        )

        await #expect(
            printerInstructions.sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrdering() == 123
        )
    }

    @Test(
        "sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrdering with real input returns correct result"
    )
    func
        sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrderingWithRealInputReturnsCorrectResult()
        async throws
    {
        let inputFileURL = try #require(
            Bundle.module.url(forResource: "real-input", withExtension: "txt")
        )

        let printerInstructions = try await PrinterInstructions(fileURL: inputFileURL)

        await #expect(
            printerInstructions.sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrdering() == 6305
        )
    }

}
