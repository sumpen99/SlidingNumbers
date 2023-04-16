//
//  CustomSecureField.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-16.
//

import SwiftUI

struct CustomSecureField: View {

    @FocusState var focus1: Bool
    @FocusState var focus2: Bool
    @State var showPassword: Bool = false
    @Binding var text : String

    var body: some View {
        HStack() {
            ZStack(alignment: .trailing) {
                TextField("Password", text: $text)
                    .modifier(LoginModifier())
                    .textContentType(.password)
                    .focused($focus1)
                    .opacity(showPassword ? 1 : 0)
                    
                SecureField("Password", text: $text)
                    .modifier(LoginModifier())
                    .textContentType(.password)
                    .focused($focus2)
                    .opacity(showPassword ? 0 : 1)
                
            }
            Image(systemName: showPassword ? "eye" : "eye.slash").onTapGesture {
                showPassword.toggle()
                if showPassword { focus1 = true } else { focus2 = true }
            }
            .padding(.trailing)
            .foregroundColor(.red)
        }
    }
}
