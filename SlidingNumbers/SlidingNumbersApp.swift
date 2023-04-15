//
//  SlidingNumbersApp.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-01.
//

import SwiftUI
import Firebase

@main
struct SlidingNumbersApp: App{
    init(){
        FirebaseApp.configure()
    }
    
    var body:some Scene {
        AppScene()
    }
}
