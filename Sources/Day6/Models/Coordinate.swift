//
//  Coordinates.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 06/12/2024.
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
        case .east: return east
        case .south: return south
        case .west: return west
        }
    }

    var north: Coordinate {
        .init(row: row - 1, column: column)
    }

    var east: Coordinate {
        .init(row: row, column: column + 1)
    }

    var south: Coordinate {
        .init(row: row + 1, column: column)
    }

    var west: Coordinate {
        .init(row: row, column: column - 1)
    }

}
