//
//  NavigationView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-01.
//

import SwiftUI

struct NavigationView: View{
    var body: some View {
        TabView{
            BoardView()
                .tabItem(){
                    Image(systemName:"play.fill")
                    Text("Play")
                }
        }
        
        .accentColor(.black)
    }
    
    /*init() {
        UITabBar.appearance().backgroundColor = UIColor.red
        UITabBar.appearance().barTintColor = .green
    }*/
}

//struct NavigationView_Previews: PreviewProvider {
    //static var previews: some View {
        //NavigationView()
    //}
//}

/*
 TabView{
     BoardView2()
         .tabItem(){
             Image(systemName:"play.fill")
             Text("Play")
         }
         .toolbarBackground(Color.red,for: .tabBar)
 }
 .accentColor(.black)
 
 TabView {
     NavigationStack {
         List {
             Text("Home Content")
                 .frame(height: 500)
         }
         .navigationTitle("Home Title")
     }
     .tabItem {
         Label("Home", systemImage: "house")
     }
     Text("Search")
     .tabItem {
         Label("Search", systemImage: "magnifyingglass")
     }
     Text("Notification")
     .tabItem {
         Label("Notification", systemImage: "bell")
     }
     Text("Settings")
     .tabItem {
         Label("Settings", systemImage: "gearshape")
     }
 }
 
 */
