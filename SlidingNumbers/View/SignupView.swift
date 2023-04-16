//
//  SignupView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-15.
//

import SwiftUI

struct SignupView : View {
    @EnvironmentObject var firebaseAuth: FirebaseAuth
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
                Section(header: Text("Password"),footer: Text("It must be at least \(MIN_PASSWORD_LEN) characters in length \nand contain at least one special character")) {
                    ToggleVisiblePasswordView()
                        .environmentObject(passwordChecker)
                }
                Section {
                    if self.passwordChecker.level.rawValue >= 2 {
                        CustomSecureField1(text: $passwordChecker.confirmedPassword)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(passwordChecker.passwordsIsAMatch ? .green : .red, lineWidth: 2)
                        }
                        if passwordChecker.passwordsIsAMatch{
                            Button(action: { signUserUp()}) {
                                Text("Sign Up")
                            }
                        }
                        else{
                            Text("Password is not a match")
                                .foregroundColor(.gray)
                                .font(.headline)
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
    
    func signUserUp(){
        printAny(firebaseAuth.isLoggedIn)
        printAny("\(passwordChecker.password) " +
                 "\(passwordChecker.confirmedPassword) " +
                 "\(passwordChecker.passwordsIsAMatch) ")
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
