//
//  PathError.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 06/12/2024.
//

import Foundation

enum PathError: Error, LocalizedError {

    case noGuard
    case noGuardDirection
    case guardStuck
    case infiniteLoop([Coordinate])
    case cantLeaveMap

    var localizedDescription: String {
        switch self {
        case .noGuard:
            return "No guard"
        case .noGuardDirection:
            return "No guard direction"
        case .guardStuck:
            return "Guard stuck"
        case .infiniteLoop(let coordinates):
            return "Infinite loop: \(coordinates)"
        case .cantLeaveMap:
            return "Can't leave map"
        }
    }

}
