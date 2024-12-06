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

    convenience init(rows: [String]) {
        let characterMap = rows.map(Array.init)
        self.init(characterMap: characterMap)
    }

    convenience init() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        try await self.init(fileURL: inputFileURL)
    }

    func numberOfXMASOccurrences() async -> Int {
        let wordCoordinatesGroup = await wordCoordinatesGroup(for: "XMAS")
        return wordCoordinatesGroup.count
    }

    func numberOfXxMASOccurrences() async -> Int {
        let wordCoordinatesGroup = await wordCoordinatesGroup(for: "MAS")
        var count = 0
        var haveSeenEachOther: [WordCoordinates: [WordCoordinates]] = [:]
        for wordCoordinates in wordCoordinatesGroup {
            let crossingDirections = wordCoordinates.direction.crossing
            for otherWordCoordinates in wordCoordinatesGroup
            where otherWordCoordinates != wordCoordinates {
                guard
                    !haveSeenEachOther[otherWordCoordinates, default: []].contains(wordCoordinates),
                    !haveSeenEachOther[wordCoordinates, default: []].contains(otherWordCoordinates)
                else {
                    continue
                }

                guard
                    wordCoordinates[1] == otherWordCoordinates[1],
                    crossingDirections.contains(otherWordCoordinates.direction)
                else {
                    continue
                }

                haveSeenEachOther[wordCoordinates, default: []].append(otherWordCoordinates)
                haveSeenEachOther[otherWordCoordinates, default: []].append(wordCoordinates)

                count += 1
            }
        }

        return count
    }

    private func wordCoordinatesGroup(
        for wordString: String
    ) async -> [WordCoordinates] {
        let searchWord = Word(wordString)
        guard let startingCharacter = searchWord.first else {
            return []
        }

        let startingCoordinates = grid.coordinates(for: startingCharacter)
        guard !startingCoordinates.isEmpty else {
            return []
        }

        let wordCoordinatesGroup = await withTaskGroup(
            of: [WordCoordinates].self, returning: [WordCoordinates].self
        ) { taskGroup in
            for startingCoordinate in startingCoordinates {
                taskGroup.addTask {
                    await self.grid.coordinatesGroup(
                        for: searchWord,
                        startingAt: startingCoordinate
                    )
                }
            }

            var wordCoordinatesGroup: [WordCoordinates] = []
            for await coordinatesGroup in taskGroup {
                wordCoordinatesGroup.append(contentsOf: coordinatesGroup)
            }

            return wordCoordinatesGroup
        }

        return wordCoordinatesGroup
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

}
