//
//  Grid.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 04/12/2024.
//

import Foundation

struct Grid: Sendable {

    private let characterMap: [[Character]]

    init(characterMap: [[Character]]) {
        self.characterMap = characterMap
    }

    func coordinates(for character: Character) -> [Coordinate] {
        var coordinates: [Coordinate] = []
        for (rowIndex, row) in characterMap.enumerated() {
            for (columnIndex, column) in row.enumerated() where column == character {
                let coordinate = Coordinate(row: rowIndex, column: columnIndex)
                coordinates.append(coordinate)
            }
        }

        return coordinates
    }

    func character(at coordinate: Coordinate) -> Character? {
        guard characterMap.indices.contains(coordinate.row) else {
            return nil
        }

        guard characterMap[coordinate.row].indices.contains(coordinate.column) else {
            return nil
        }

        return characterMap[coordinate.row][coordinate.column]
    }

    func coordinatesGroup(
        for word: Word,
        startingAt startCoordinate: Coordinate
    ) async -> [WordCoordinates] {
        let directionsToSearch: [Direction] = {
            let nextCharacter = word[1]
            var directions: [Direction] = []

            if character(at: startCoordinate.north) == nextCharacter {
                directions.append(.north)
            }

            if character(at: startCoordinate.northEast) == nextCharacter {
                directions.append(.northEast)
            }

            if character(at: startCoordinate.east) == nextCharacter {
                directions.append(.east)
            }

            if character(at: startCoordinate.southEast) == nextCharacter {
                directions.append(.southEast)
            }

            if character(at: startCoordinate.south) == nextCharacter {
                directions.append(.south)
            }

            if character(at: startCoordinate.southWest) == nextCharacter {
                directions.append(.southWest)
            }

            if character(at: startCoordinate.west) == nextCharacter {
                directions.append(.west)
            }

            if character(at: startCoordinate.northWest) == nextCharacter {
                directions.append(.northWest)
            }

            return directions
        }()

        let wordCoordinatesGroup = await withTaskGroup(
            of: Optional<WordCoordinates>.self,
            returning: [WordCoordinates].self
        ) { taskGroup in
            for direction in directionsToSearch {
                taskGroup.addTask {
                    await self.wordCoordinates(
                        for: word,
                        startingAt: startCoordinate,
                        inDirection: direction
                    )
                }
            }

            var wordCoordinatesGroup: [WordCoordinates] = []
            for await wordCoordinates in taskGroup {
                if let wordCoordinates {
                    wordCoordinatesGroup.append(wordCoordinates)
                }
            }

            return wordCoordinatesGroup
        }

        return wordCoordinatesGroup
    }

    private func wordCoordinates(
        for word: Word,
        startingAt startCoordinate: Coordinate,
        inDirection direction: Direction
    ) async -> WordCoordinates? {
        var wordCoordinates = WordCoordinates()
        var currentCoordinate = startCoordinate
        wordCoordinates.append(currentCoordinate)

        for (index, searchCharacter) in word.enumerated() where index >= 1 {
            if character(at: currentCoordinate.move(in: direction)) == searchCharacter {
                currentCoordinate = currentCoordinate.move(in: direction)
                wordCoordinates.append(currentCoordinate)
                continue
            }

            break
        }

        guard wordCoordinates.count == word.count else {
            return nil
        }

        return wordCoordinates
    }

}
