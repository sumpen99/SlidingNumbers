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
    
    private enum Field: Int {
        case textEditName
        case textEditEmail
        case textEditPassword
    }

    @FocusState private var focusedField: Field?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Info")) {
                    TextField("Name",text: $name)
                        .focused($focusedField, equals: .textEditName)
                    TextField("Email",text: $email)
                        .focused($focusedField, equals: .textEditEmail)
                }
                Section(header: Text("Password"),footer: Text("It must be at least \(MIN_PASSWORD_LEN) characters in length \nand contain at least one special character")) {
                    ToggleVisiblePasswordView()
                        .environmentObject(passwordChecker)
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
        /*.onTapGesture {
            if (focusedField != nil) {
                focusedField = nil
            }
        }*/
        /*.onTapGesture {
            // Hide Keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({ gesture in
                // Hide keyboard on swipe down
                if gesture.translation.height > 0 {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        }))*/
    }
}

/*
 
 struct ContentView: View {
     
     @Binding var text: String
     
     private enum Field: Int {
         case yourTextEdit
     }

     @FocusState private var focusedField: Field?

     var body: some View {
         VStack {
             TextEditor(text: $speech.text.bound)
                 .padding(Edge.Set.horizontal, 18)
                 .focused($focusedField, equals: .yourTextEdit)
         }.onTapGesture {
             if (focusedField != nil) {
                 focusedField = nil
             }
         }
     }
 }
 
 
 */
