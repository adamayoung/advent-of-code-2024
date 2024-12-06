//
//  SumOfAllMultiplicationsWithConditionalsTests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 03/12/2024.
//

import Testing

@testable import Day3

@Suite("Sum of all multiplications with conditionals tests")
struct SumOfAllMultiplicationsWithConditionalsTests {

    @Test("sumOfAllMultiplicationsWithConditionals when using test data returns correct result")
    func sumOfAllMultiplicationsWithConditionalsWhenUsingTestDataReturnsCorrectResult() async {
        let data = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

        let processor = CalculationProcessor(data: data)

        #expect(processor.sumOfAllMultiplications(withConditionals: true) == 48)
    }

    @Test("sumOfAllMultiplicationsWithConditionals with real input returns correct result")
    func sumOfAllMultiplicationsWithConditionalsWithRealInputReturnsCorrectResult() async throws {
        let processor = try await CalculationProcessor()

        #expect(processor.sumOfAllMultiplications(withConditionals: true) == 89_823_704)
    }

}
