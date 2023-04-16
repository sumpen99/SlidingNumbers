//
//  LoginModifier.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-16.
//

import SwiftUI

struct LoginModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .padding()
    }
}
