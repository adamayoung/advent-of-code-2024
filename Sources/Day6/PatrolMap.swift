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
    }

    convenience init() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        try await self.init(fileURL: inputFileURL)
    }

    func numberOfDistinctPositionsToLeaveMap() -> Int {
        var guardCoordinate = guardStartingCoordinate
        guard guardCoordinate != nil else {
            return 0
        }

        guard var guardDirection = guardStartingDirection else {
            return 0
        }

        var path: Set<Coordinate> = []
        repeat {
            guard let coordinate = guardCoordinate else {
                break
            }

            path.insert(coordinate)

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

            break
        } while guardCoordinate != nil

        return path.count
    }

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
