//
//  SignupView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-15.
//

import SwiftUI

struct SignupView : View {
    @State private var terms: Bool = false
    @State private var name: String = ""
    @State private var email: String = ""
    @ObservedObject var passwordChecker: PasswordChecker = PasswordChecker()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Info")) {
                    TextField("Name",text: $name)
                    TextField("Email",text: $email)
                }
                Section(header: Text("Password")) {
                    TextField("Password",text:$passwordChecker.password)
                    if !self.passwordChecker.password.isEmpty {
                        SecureLevelView(level: self.passwordChecker.level)
                    }
                }
                Section {
                    if self.passwordChecker.level.rawValue >= 2 {
                        Toggle(isOn: $terms) {
                            Text("Accept the terms and conditions")
                        }
                        if self.terms {
                            Button(action: {
                                print("register account")
                            }) {
                                Text("OK")
                            }
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(
              LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
            .navigationBarTitle(Text("Registration Form"))
        }
    }
}
