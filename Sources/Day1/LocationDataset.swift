//
//  LocationDataset.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 02/12/2024.
//

import Foundation

final class LocationDataset: Sendable {

    private let locations1: [Int]
    private let locations2: [Int]

    init(locations1: [Int], locations2: [Int]) {
        self.locations1 = locations1
        self.locations2 = locations2
    }

    convenience init() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        try await self.init(fileURL: inputFileURL)
    }

    func totalDistance() async -> Int {
        async let locations1 = Task { self.locations1.sorted() }
        async let locations2 = Task { self.locations2.sorted() }
        let zippedLocations = await zip(locations1.value, locations2.value)

        let totalDistance = await withTaskGroup(of: Int.self) { taskGroup in
            for (location1, location2) in zippedLocations {
                taskGroup.addTask { abs(location1 - location2) }
            }

            return await taskGroup.reduce(into: 0, +=)
        }

        return totalDistance
    }

    func similarityScore() async -> Int {
        let location2Counts = locations2.reduce(into: [:]) { $0[$1, default: 0] += 1 }

        let similarityScore = await withTaskGroup(of: Int.self) { taskGroup in
            for location1 in locations1 {
                taskGroup.addTask { location1 * location2Counts[location1, default: 0] }
            }

            return await taskGroup.reduce(into: 0, +=)
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
