//
//  Day5Tests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 05/12/2024.
//

import Foundation
import Testing

@testable import Day5

@Suite("Sum of middle pages for correctly ordered updates tests")
struct SumOfMiddlePagesForCorrectlyOrderedUpdatesTests {

    @Test(
        "sumOfMiddlePagesForCorrectlyOrderedUpdates when using test data 1 returns correct result")
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

        await #expect(printerInstructions.sumOfMiddlePagesForCorrectlyOrderedUpdates() == 143)
    }

    @Test("sumOfMiddlePagesForCorrectlyOrderedUpdates with real input returns correct result")
    func sumOfMiddlePagesForCorrectlyOrderedUpdatesWithRealInputReturnsCorrectResult() async throws
    {
        let printerInstructions = try await PrinterInstructions()

        await #expect(printerInstructions.sumOfMiddlePagesForCorrectlyOrderedUpdates() == 6034)
    }

}
