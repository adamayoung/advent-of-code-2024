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
        let possibleDirections: [Direction] = {
            let nextCharacter = word[1]
            var possibleDirections: [Direction] = []

            for directionToSearch in Direction.allCases
            where character(at: startCoordinate.move(in: directionToSearch)) == nextCharacter {
                possibleDirections.append(directionToSearch)
            }

            return possibleDirections
        }()

        let wordCoordinatesGroup = await withTaskGroup(
            of: Optional<WordCoordinates>.self,
            returning: [WordCoordinates].self
        ) { taskGroup in
            for direction in possibleDirections {
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
        var coordinates: [Coordinate] = []
        var currentCoordinate = startCoordinate
        coordinates.append(currentCoordinate)

        for (index, searchCharacter) in word.enumerated() where index >= 1 {
            if character(at: currentCoordinate.move(in: direction)) == searchCharacter {
                currentCoordinate = currentCoordinate.move(in: direction)
                coordinates.append(currentCoordinate)
                continue
            }

            break
        }

        guard coordinates.count == word.count else {
            return nil
        }

        return WordCoordinates(coordinates: coordinates, direction: direction)
    }

}
