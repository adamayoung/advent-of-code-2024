//
//  Marker.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 06/12/2024.
//

import Foundation

enum Marker: Equatable {

    case empty
    case obstruction
    case labGuard(Direction)

    init?(character: Character) {
        switch character {
        case ".": self = .empty
        case "#": self = .obstruction
        case "^": self = .labGuard(.north)
        case ">": self = .labGuard(.east)
        case "v": self = .labGuard(.south)
        case "<": self = .labGuard(.west)
        default: return nil
        }
    }

    var isLabGuard: Bool {
        switch self {
        case .labGuard: return true
        default: return false
        }
    }

}
