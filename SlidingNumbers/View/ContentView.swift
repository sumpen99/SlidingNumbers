//
//  ContentView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-15.
//
import SwiftUI

struct ContentView: OptionalView {

    @EnvironmentObject var firebaseAuth: FirebaseAuth
    
    var isPrimaryView: Bool { firebaseAuth.isLoggedIn }
    
    init(){
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        //UITabBar.appearance().backgroundColor = UIColor.white
        //UITabBar.appearance().isTranslucent = false
    }
    
    var primaryView: some View {
        TabView {
            GameMenuView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            GameMenuView()
                .tabItem {
                    Label("HighScore", systemImage: "star.square.fill")
                }
            GameMenuView()
                .tabItem {
                    Label("Person", systemImage: "person.fill")
                }
        }
        .accentColor(.green)
    }
    
    var optionalView: some View {
        LoginView()
            .transition(.slide)
    }
    
}
