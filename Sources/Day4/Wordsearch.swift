//
//  Wordsearch.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 04/12/2024.
//

import Foundation

final class Wordsearch: Sendable {

    private let grid: Grid

    init(grid: Grid) {
        self.grid = grid
    }

    convenience init(characterMap: [[Character]]) {
        let grid = Grid(characterMap: characterMap)
        self.init(grid: grid)
    }

    func numberOfOccurrences(of word: String) async -> Int {
        let searchCharacters = [Character](word)
        guard let startingCharacter = searchCharacters.first else {
            return 0
        }

        let startingCoordinates = grid.coordinates(for: startingCharacter)
        guard !startingCoordinates.isEmpty else {
            return 0
        }

        guard searchCharacters.count >= 2 else {
            return startingCoordinates.count
        }

        let wordCoordinatesGroup = await withTaskGroup(
            of: [WordCoordinates].self, returning: [WordCoordinates].self
        ) { taskGroup in
            for startingCoordinate in startingCoordinates {
                taskGroup.addTask {
                    await self.grid.coordinatesGroup(
                        for: searchCharacters,
                        startingAt: startingCoordinate
                    )
                }
            }

            var wordCoordinatesGroup: [WordCoordinates] = []
            for await coordinatesGroup in taskGroup {
                for coordinates in coordinatesGroup {
                    wordCoordinatesGroup.append(coordinates)
                }
            }

            return wordCoordinatesGroup
        }

        return wordCoordinatesGroup.count
    }

}

extension Wordsearch {

    convenience init(fileURL: URL) async throws {
        guard let handle = try? FileHandle(forReadingFrom: fileURL) else {
            fatalError("cannot open input file")
        }

        defer {
            try? handle.close()
        }

        var rows: [String] = []
        for try await line in handle.bytes.lines {
            rows.append(line)
        }

        self.init(rows: rows)
    }

    convenience init(rows: [String]) {
        let characterMap = rows.map(Array.init)
        self.init(characterMap: characterMap)
    }

}
