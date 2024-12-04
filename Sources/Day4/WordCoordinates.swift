//
//  WordCoordinates.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 04/12/2024.
//

import Foundation

struct WordCoordinates: Sendable, Equatable, Hashable {

    let coordinates: [Coordinate]
    let direction: Direction

    subscript(_ index: Int) -> Coordinate {
        coordinates[index]
    }

}
