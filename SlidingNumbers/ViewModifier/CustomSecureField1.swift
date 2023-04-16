//
//  CustomSecureField1.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-16.
//

import SwiftUI

struct CustomSecureField1 : View {
    @Binding var text : String
    @State var isEditing = false
    @State var showPassword = false
    var label:String = "Password"
    var body : some View {
        let showPasswordBinding = Binding<String> {
            self.text
        } set: {
            self.text = $0
        }
        let hidePasswordBinding = Binding<String> {
            String.init(repeating: "●", count: self.text.count)
        } set: { newValue in
            if(newValue.count < self.text.count) {
                self.text = ""
            } else {
                self.text.append(contentsOf: newValue.suffix(newValue.count - self.text.count) )
            }
        }

        return ZStack(alignment: .trailing) {
            HStack{
                TextField(
                    label,
                    text: showPassword ? showPasswordBinding : hidePasswordBinding,
                    onEditingChanged: { editingChanged in
                        isEditing = editingChanged
                    }
                )
                .textContentType(.password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                Image(systemName: showPassword ? "eye" : "eye.slash").onTapGesture {
                    showPassword.toggle()
                }
                .foregroundColor(.red)
            }
            .padding()
        }
        
    }
}
