//
//  Day3.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 03/12/2024.
//

import Foundation

///
/// Day 3: Mull It Over
///
@main
struct Day3 {

    static func main() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        let processor = try await CalculationProcessor(fileURL: inputFileURL)
        let sumOfAllMultiplications = processor.sumOfAllMultiplications()
        let sumOfAllMultiplicationsWithConditionals =
            processor.sumOfAllMultiplications(withConditionals: true)

        printResults(
            sumOfAllMultiplications: sumOfAllMultiplications,
            sumOfAllMultiplicationsWithConditionals: sumOfAllMultiplicationsWithConditionals
        )
    }

    private static func printResults(
        sumOfAllMultiplications: Int,
        sumOfAllMultiplicationsWithConditionals: Int
    ) {
        print("Day 3: Mull It Over")
        print("========================\n")
        print("sumOfAllMultiplications: \(sumOfAllMultiplications)")
        print("sumOfAllMultiplicationsWithConditionals: \(sumOfAllMultiplicationsWithConditionals)")
    }

}
