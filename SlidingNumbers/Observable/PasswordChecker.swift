//
//  PasswordChecker.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-15.
//

import SwiftUI

class PasswordChecker: ObservableObject {
    @Published public var didChange = false
    var password: String = "" {
        didSet {
            self.checkForPassword(password: self.password)
        }
    }

    var level: PasswordLevel = .none {
        didSet {
            self.didChange.toggle()
        }
    }

    func checkForPassword(password: String) {
        if password.count == 0 {
            self.level = .none
        } else if password.count < 2 {
            self.level = .weak
        } else if password.count < 6 {
            self.level = .ok
        } else {
            self.level = .strong
        }
    }
}
