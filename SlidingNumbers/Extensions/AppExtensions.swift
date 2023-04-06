//
//  AppExtensions.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-04.
//


import SwiftUI

extension UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let standardAppearance = UITabBarAppearance()
        standardAppearance.backgroundColor = .red
        standardAppearance.shadowColor = .green
        standardAppearance.backgroundImage = UIImage(named: "wood1")

        tabBar.standardAppearance = standardAppearance
    }
}

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

extension Int {
    static func getUniqueRandomNumbers(min: Int, max: Int, count: Int) -> [Int] {
        var set = Set<Int>()
        while set.count < count {
            set.insert(Int.random(in: min...max))
        }
        return Array(set)
    }

}

extension RangeExpression where Bound: FixedWidthInteger {
    func randomElements(_ n: Int) -> [Bound] {
        precondition(n > 0)
        switch self {
        case let range as Range<Bound>: return (0..<n).map { _ in .random(in: range) }
        case let range as ClosedRange<Bound>: return (0..<n).map { _ in .random(in: range) }
        default: return []
        }
    }
}

extension Range where Bound: FixedWidthInteger {
    var randomElement: Bound { .random(in: self) }
}

extension ClosedRange where Bound: FixedWidthInteger {
    var randomElement: Bound { .random(in: self) }
}
