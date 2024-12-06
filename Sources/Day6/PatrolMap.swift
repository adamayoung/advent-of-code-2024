//
//  PatrolMap.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 06/12/2024.
//

import Foundation

final class PatrolMap: Sendable {

    private let squares: [[Marker]]

    var guardStartingCoordinate: Coordinate? {
        for (rowIndex, row) in squares.enumerated() where row.filter(\.isLabGuard).count > 0 {
            for (columnIndex, square) in row.enumerated() where square.isLabGuard {
                return Coordinate(row: rowIndex, column: columnIndex)
            }
        }

        return nil
    }

    var guardStartingDirection: Direction? {
        for row in squares where row.filter(\.isLabGuard).count > 0 {
            for square in row where square.isLabGuard {
                switch square {
                case .labGuard(let direction): return direction
                default: return nil
                }
            }
        }

        return nil
    }

    init(squares: [[Marker]]) {
        self.squares = squares
        guard guardStartingCoordinate != nil else {
            fatalError("No guard on map")
        }
    }

    convenience init() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        try await self.init(fileURL: inputFileURL)
    }

    func numberOfDistinctPositionsToLeaveMap() -> Int {
        let count: Int
        do {
            let path = try pathLeaveToArea()
            let distinctCoordinates = Set(path)
            count = distinctCoordinates.count
        } catch {
            return 0
        }

        return count
    }

    func numberOfAddedObstructionsForLoop() async -> Int {
        guard
            let guardStartingCoordinate = self.guardStartingCoordinate,
            let guardStartingDirection = self.guardStartingDirection
        else {
            fatalError(PathError.noGuard.localizedDescription)
        }
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

        let obstacleCount: Int = await withTaskGroup(of: Int.self) { taskGroup in
            for coordinate in possibleNewObstructionCoordinates {
                taskGroup.addTask {
                    var squares = self.squares
                    squares[coordinate.row][coordinate.column] = .obstruction

                    let map = PatrolMap(squares: squares)

                    do {
                        _ = try map.pathLeaveToArea()
                    } catch let error as PathError {
                        switch error {
                        case .infiniteLoop:
                            return 1

                        case .cantLeaveMap:
                            return 0
                        default:
                            return 0
                        }
                    } catch {
                        return 0
                    }

                    return 0
                }
            }

            return await taskGroup.reduce(into: 0, +=)
        }

        return obstacleCount
    }

}

extension PatrolMap {

    private func pathLeaveToArea() throws(PathError) -> [Coordinate] {
        var guardCoordinate = guardStartingCoordinate
        guard guardCoordinate != nil else {
            throw .noGuard
        }

        guard var guardDirection = guardStartingDirection else {
            throw .noGuardDirection
        }

        var path: [Coordinate] = []
        var seen: [Coordinate: Direction] = [:]
        repeat {
            guard let coordinate = guardCoordinate else {
                break
            }

            path.append(coordinate)
            if seen[coordinate] == guardDirection {
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
