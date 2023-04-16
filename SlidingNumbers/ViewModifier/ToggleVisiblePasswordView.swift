//
//  ToggleVisiblePasswordView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-16.
//

import SwiftUI


struct ToggleVisiblePasswordView : View {
    @EnvironmentObject var passwordChecker: PasswordChecker
    @State private var showPassword: Bool = true
    
    var body: some View {
        if self.passwordChecker.level != .none {
            SecureLevelView(level: self.passwordChecker.level)
        }
        CustomSecureField1(text: $passwordChecker.password)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.opaqueSeparator), lineWidth: 2)
        }
        
    }
}
