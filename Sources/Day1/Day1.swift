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
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt") else {
            fatalError("input file missing")
        }

        let dataset = try await LocationDataset(fileURL: inputFileURL)
        let totalDistance = dataset.totalDistance

        print("Total distance: \(totalDistance)")
    }

}
