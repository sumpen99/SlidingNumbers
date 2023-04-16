//
//  TextfieldLimitModifier.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-16.
//
import SwiftUI

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}
