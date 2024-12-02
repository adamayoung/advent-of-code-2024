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

    var totalDistance: Int {
        calculateTotalDistnace()
    }

    init(locations1: [Int], locations2: [Int]) {
        self.locations1 = locations1
        self.locations2 = locations2
    }

    private func calculateTotalDistnace() -> Int {
        let locations1 = self.locations1.sorted()
        let locations2 = self.locations2.sorted()

        let zipped = zip(locations1, locations2)
        var totalDistance = 0
        for locations in zipped {
            let location1 = locations.0
            let location2 = locations.1
            totalDistance += abs(location1 - location2)
        }

        return totalDistance
    }

}

extension LocationDataset {

    convenience init(fileURL: URL) async throws {
        guard let handle: FileHandle = try? FileHandle(forReadingFrom: fileURL) else {
            fatalError("cannot open input file")
        }

        defer {
            try? handle.close()
        }

        var locations1 = [Int]()
        var locations2 = [Int]()

        for try await line in handle.bytes.lines {
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

            locations1.append(location1)
            locations2.append(location2)
        }

        self.init(locations1: locations1, locations2: locations2)
    }

}
