//
//  Coordinate.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 04/12/2024.
//

import Foundation

struct Coordinate: Sendable, Equatable, Hashable, CustomStringConvertible {

    let row: Int
    let column: Int

    var description: String {
        "(\(row), \(column))"
    }

    func move(in direction: Direction) -> Coordinate {
        switch direction {
        case .north: return north
        case .northEast: return northEast
        case .east: return east
        case .southEast: return southEast
        case .south: return south
        case .southWest: return southWest
        case .west: return west
        case .northWest: return northWest
        }
    }

    var north: Coordinate {
        .init(row: row - 1, column: column)
    }

    var northEast: Coordinate {
        .init(row: row - 1, column: column + 1)
    }

    var east: Coordinate {
        .init(row: row, column: column + 1)
    }

    var southEast: Coordinate {
        .init(row: row + 1, column: column + 1)
    }

    var south: Coordinate {
        .init(row: row + 1, column: column)
    }

    var southWest: Coordinate {
        .init(row: row + 1, column: column - 1)
    }

    var west: Coordinate {
        .init(row: row, column: column - 1)
    }

    var northWest: Coordinate {
        .init(row: row - 1, column: column - 1)
    }

}
