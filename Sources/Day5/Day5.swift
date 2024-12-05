//
//  Day5.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 05/12/2024.
//

import Foundation

///
/// Day 5: Print Queue
///
@main
struct Day5 {

    static func main() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        let printerInstructions = try await PrinterInstructions(fileURL: inputFileURL)
        let sumOfMiddlePagesForCorrectlyOrderedUpdates =
            printerInstructions
            .sumOfMiddlePagesForCorrectlyOrderedUpdates()

        printResults(
            sumOfMiddlePagesForCorrectlyOrderedUpdates: sumOfMiddlePagesForCorrectlyOrderedUpdates
        )
    }

    private static func printResults(
        sumOfMiddlePagesForCorrectlyOrderedUpdates sumOfUpdates: Int
    ) {
        print("Day 5: Print Queue")
        print("========================\n")
        print("sumOfMiddlePagesForCorrectlyOrderedUpdates: \(sumOfUpdates)")
    }

}
