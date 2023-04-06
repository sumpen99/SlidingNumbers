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
                    Text("New Game")
                }
            ViewB()
                .tabItem(){
                    Image(systemName: "person.2.fill")
                    Text("Contacts")
                }
        }
        .accentColor(.black)
    }
    
    init() {
        //let bgView = UIImageView(image: UIImage(named: "wood1"))
        //bgView.frame = self.tabBar.bounds
        //self.tabBar.addSubview(bgView)
        //self.tabBar.sendSubview(toBack: bgView)
        //UITabBar.appearance().backgroundColor = UIColor.brown
        //UITabBar.appearance().barTintColor = .green
        //UITabBar.appearance().barTintColor = UIColor.clear
        //UITabBar.appearance().shadowImage = UIImage(named: "wood1.png")
        //UITabBar.appearance().backgroundImage = UIImage(named:"wood3")
        //UITabBar.appearance().isTranslucent = false
        //UITabBar.appearance().backgroundColor = UIColor.clear
        //UITabBar.appearance().backgroundImage = UIImage(named: "wood2")
        //UITabBar.appearance().contentMode = .scaleAspectFit
        
    }
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
