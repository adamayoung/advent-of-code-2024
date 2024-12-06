//
//  Day3Tests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 03/12/2024.
//

import Testing

@testable import Day3

@Suite("Sum of all multiplications tests")
struct SumOfAllMultiplicationsTests {

    @Test("sumOfAllMultiplications when using test data returns correct result")
    func sumOfAllMultiplicationsWhenUsingTestDataReturnsCorrectResult() async {
        let data = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

        let processor = CalculationProcessor(data: data)

        #expect(processor.sumOfAllMultiplications() == 161)
    }

    @Test("sumOfAllMultiplications with real input returns correct result")
    func sumOfAllMultiplicationsWithRealInputReturnsCorrectResult() async throws {
        let processor = try await CalculationProcessor()

        #expect(processor.sumOfAllMultiplications() == 167_090_022)
    }

}
