//
//  Day1.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

///
/// Day 1: Historian Hysteria
///
@main
struct Day1 {

    static func main() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        let dataset = try await LocationDataset(fileURL: inputFileURL)
        let totalDistance = dataset.totalDistance()
        let similarityScore = dataset.similarityScore()

        printResults(totalDistance: totalDistance, similarityScore: similarityScore)
    }

    private static func printResults(totalDistance: Int, similarityScore: Int) {
        print("Day 1: Historian Hysteria")
        print("=========================\n")
        print("Total distance: \(totalDistance)")
        print("Similarity score: \(similarityScore)")
    }

}
