//
//  Direction.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 04/12/2024.
//

import Foundation

enum Direction: Hashable, CaseIterable {

    case north
    case northEast
    case east
    case southEast
    case south
    case southWest
    case west
    case northWest

    var diagonals: [Direction] {
        [.northEast, .southEast, .southWest, .northWest]
    }

    var crossing: [Direction] {
        switch self {
        case .northEast: return [.southEast, .southEast.opposite]
        case .southEast: return [.northEast, .northEast.opposite]
        case .southWest: return [.southEast, .southEast.opposite]
        case .northWest: return [.northEast, .northEast.opposite]
        default: return []
        }
    }

    var opposite: Direction {
        switch self {
        case .north: return .south
        case .northEast: return .southWest
        case .east: return .west
        case .southEast: return .northWest
        case .south: return .north
        case .southWest: return .northEast
        case .west: return .east
        case .northWest: return .southEast
        }
    }

}
