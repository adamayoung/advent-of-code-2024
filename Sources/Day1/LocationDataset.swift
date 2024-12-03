//
//  LocationDataset.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

final class LocationDataset: Sendable {

    let locations1: [Int]
    let locations2: [Int]

    init(locations1: [Int], locations2: [Int]) {
        self.locations1 = locations1
        self.locations2 = locations2
    }

    func totalDistance() -> Int {
        let locations1 = self.locations1.sorted()
        let locations2 = self.locations2.sorted()
        let zippedLocations = zip(locations1, locations2)

        let totalDistance = zippedLocations.reduce(0) { totalDistance, locationGroup in
            let distance = abs(locationGroup.0 - locationGroup.1)
            return totalDistance + distance
        }

        return totalDistance
    }

    func similarityScore() -> Int {
        var location2Counts: [Int: Int] = [:]
        for location2 in locations2 {
            location2Counts[location2, default: 0] += 1
        }

        let similarityScore = locations1.reduce(0) { score, location1 in
            let numberOfOccurrences = location2Counts[location1, default: 0]
            return score + (location1 * numberOfOccurrences)
        }

        return similarityScore
    }

}

extension LocationDataset {

    convenience init(fileURL: URL) async throws {
        guard let handle = try? FileHandle(forReadingFrom: fileURL) else {
            fatalError("cannot open input file")
        }

        defer {
            try? handle.close()
        }

        var locations1: [Int] = []
        var locations2: [Int] = []

        for try await line in handle.bytes.lines {
            let (location1, location2) = Self.locations(from: line)

            locations1.append(location1)
            locations2.append(location2)
        }

        self.init(locations1: locations1, locations2: locations2)
    }

    private static func locations(from line: String) -> (Int, Int) {
        let ids = line.split(separator: "   ")
        guard ids.count == 2 else {
            fatalError("invalid line: \(line)")
        }

        guard
            let location1 = Int(ids[0]),
            let location2 = Int(ids[1])
        else {
            fatalError("invalid line: \(line)")
        }

        return (location1, location2)
    }

}
