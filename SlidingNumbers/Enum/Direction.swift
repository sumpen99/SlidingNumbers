//
//  Direction.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-04.
//

import Foundation

extension Direction {
    static var allValues: [Direction] {
        var allValues: [Direction] = []
        switch (Direction.NORTH) {
        case .NORTH: allValues.append(.NORTH); fallthrough
        case .SOUTH: allValues.append(.SOUTH); fallthrough
        case .EAST: allValues.append(.EAST); fallthrough
        case .WEST: allValues.append(.WEST);
        }
        return allValues
    }
}

enum Direction{
    case NORTH,SOUTH,EAST,WEST
}
