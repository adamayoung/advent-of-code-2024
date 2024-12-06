//
//  PatrolMap.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 06/12/2024.
//

import Foundation

final class PatrolMap: Sendable {

    let squares: [[Marker]]
    let guardStartingCoordinate: Coordinate
    let guardStartingDirection: Direction

    init(squares: [[Marker]]) {
        self.squares = squares

        var guardStartingCoordinate: Coordinate?
        var guardStartingDirection: Direction?
        for (rowIndex, row) in squares.enumerated() where row.filter(\.isLabGuard).count > 0 {
            guard guardStartingCoordinate == nil else {
                break
            }

            for (columnIndex, square) in row.enumerated() where square.isLabGuard {
                guardStartingCoordinate = Coordinate(row: rowIndex, column: columnIndex)
                switch square {
                case .labGuard(let direction):
                    guardStartingDirection = direction
                    break
                default: break
                }
            }
        }

        guard let guardStartingCoordinate, let guardStartingDirection else {
            fatalError("No guard on map")
        }

        self.guardStartingCoordinate = guardStartingCoordinate
        self.guardStartingDirection = guardStartingDirection
    }

    convenience init() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        try await self.init(fileURL: inputFileURL)
    }

    func numberOfDistinctPositionsToLeaveMap() -> Int {
        let path = (try? pathLeaveToArea()) ?? []
        let distinctCoordinates = Set(path)
        return distinctCoordinates.count
    }

    func numberOfAddedObstructionsForLoop() async -> Int {
        let coordinateInFrontOfGuard: Coordinate = {
            let coord = guardStartingCoordinate.move(in: guardStartingDirection)
            guard square(at: coord) != nil else {
                fatalError()
            }

            return coord
        }()

        guard let pathToLeaveMap = try? self.pathLeaveToArea() else {
            fatalError(PathError.guardStuck.localizedDescription)
        }

        let pathToLeaveMapSet = Set(pathToLeaveMap)

        let possibleNewObstructionCoordinates = pathToLeaveMapSet.subtracting([
            guardStartingCoordinate, coordinateInFrontOfGuard
        ])

        let obstacleCount = await withTaskGroup(of: Int.self) { taskGroup in
            for coordinate in possibleNewObstructionCoordinates {
                taskGroup.addTask {
                    var squares = self.squares
                    squares[coordinate.row][coordinate.column] = .obstruction
                    let map = PatrolMap(squares: squares)
                    return map.isPathInfiniteLoopToLeaveArea() ? 1 : 0
                }
            }

            return await taskGroup.reduce(into: 0, +=)
        }

        return obstacleCount
    }

}

extension PatrolMap {

    private func pathLeaveToArea() throws(PathError) -> [Coordinate] {
        var guardCoordinate: Coordinate? = guardStartingCoordinate
        var guardDirection = guardStartingDirection

        var path: [Coordinate] = []
        var seen: [Coordinate: Direction] = [:]
        repeat {
            guard let coordinate = guardCoordinate else {
                break
            }

            path.append(coordinate)
            guard seen[coordinate] != guardDirection else {
                throw .infiniteLoop(path)
            }

            seen[coordinate] = guardDirection

            var nextCoordinate = coordinate.move(in: guardDirection)
            var nextSquare = square(at: nextCoordinate)
            if nextSquare == nil {
                break
            }
            if nextSquare != .obstruction {
                guardCoordinate = nextCoordinate
                continue
            }

            guardDirection = guardDirection.rotatingRight
            nextCoordinate = coordinate.move(in: guardDirection)
            nextSquare = square(at: nextCoordinate)
            if nextSquare == nil {
                break
            }
            if nextSquare != .obstruction {
                guardCoordinate = nextCoordinate
                continue
            }

            guardDirection = guardDirection.rotatingRight
            nextCoordinate = coordinate.move(in: guardDirection)
            nextSquare = square(at: nextCoordinate)
            if nextSquare == nil {
                break
            }
            if nextSquare != .obstruction {
                guardCoordinate = nextCoordinate
                continue
            }

            guardDirection = guardDirection.rotatingRight
            nextCoordinate = coordinate.move(in: guardDirection)
            nextSquare = square(at: nextCoordinate)
            if nextSquare == nil {
                break
            }
            if nextSquare != .obstruction {
                guardCoordinate = nextCoordinate
                continue
            }

            throw .guardStuck
        } while guardCoordinate != nil

        return path
    }

    private func isPathInfiniteLoopToLeaveArea() -> Bool {
        do {
            _ = try pathLeaveToArea()
        } catch let error {
            switch error {
            case .infiniteLoop: return true
            default: return false
            }
        }

        return false
    }

}

extension PatrolMap {

    private func square(at coordinate: Coordinate) -> Marker? {
        guard
            squares.indices.contains(coordinate.row),
            squares[coordinate.row].indices.contains(coordinate.column)
        else {
            return nil
        }

        return squares[coordinate.row][coordinate.column]
    }

}

extension PatrolMap {

    convenience init(fileURL: URL) async throws {
        guard let handle = try? FileHandle(forReadingFrom: fileURL) else {
            fatalError("cannot open input file")
        }

        defer {
            try? handle.close()
        }

        var squares: [[Marker]] = []
        for try await line in handle.bytes.lines {
            let row = line.compactMap(Marker.init)
            squares.append(row)
        }

        self.init(squares: squares)
    }

}
