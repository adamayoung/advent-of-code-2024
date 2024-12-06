//
//  Direction.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 06/12/2024.
//

import Foundation

enum Direction: Hashable, CaseIterable {

    case north
    case east
    case south
    case west

    var rotatingRight: Direction {
        switch self {
        case .north: return .east
        case .east: return .south
        case .south: return .west
        case .west: return .north
        }
    }

}
