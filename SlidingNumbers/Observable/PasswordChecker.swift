//
//  PasswordChecker.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-15.
//

import SwiftUI

struct Constants {
    static let lower = "abcdefghijklmnopqrstuvwxyz"
    static let upper = lower.uppercased()
    static let numbers = "0123456789"
    static let validChars = Array(lower+upper+numbers)
    
}

class PasswordChecker: ObservableObject {
    @Published public var didChange = false
    @Published var confirmedPassword: String = ""

    let constants = Constants.validChars
   
    var password: String = "" {
        didSet {
            self.checkForPassword(password:self.password)
        }
    }
    
        
    var level: PasswordLevel = .none {
        didSet {
            self.didChange.toggle()
        }
    }
    
    var passwordsIsAMatch : Bool { return self.level.rawValue >= 2 && password == confirmedPassword}
    
    func checkForPassword(password:String) {
        let numOfSpecialChars = password.filter{ !self.constants.contains($0) && $0 != "●"}.count
        if password.count < MIN_PASSWORD_LEN{
            self.level = .none
        } else if numOfSpecialChars == 0 {
            self.level = .weak
        } else if numOfSpecialChars == 1 {
            self.level = .ok
        } else {
            self.level = .strong
        }
    }
    
    deinit{
        printAny("deinit passwordchecker")
    }
    
}
