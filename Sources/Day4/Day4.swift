//
//  Day4.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 04/12/2024.
//

import Foundation

///
/// Day 4: Ceres Search
///
@main
struct Day4 {

    static func main() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        let wordsearch = try await Wordsearch(fileURL: inputFileURL)
        let numberOfXmasOccurrences = await wordsearch.numberOfOccurrences(of: "XMAS")

        printResults(numberOfXmasOccurrences: numberOfXmasOccurrences)
    }

    private static func printResults(numberOfXmasOccurrences: Int) {
        print("Day 4: Ceres Search")
        print("========================\n")
        print("numberOfXmasOccurrences: \(numberOfXmasOccurrences)")
    }

}