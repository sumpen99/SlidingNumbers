//
//  NavigationView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-01.
//

import SwiftUI

struct NavigationView: View{
    
    @State private var showingSheet = false
    
    func setBoardRows(_ rows:Int){
        BOARDER_ROWS = rows
        showingSheet.toggle()
    }
    
    func getButton(_ rows:Int) -> some View{
       return Button(
            action: { setBoardRows(rows) },
            label: {
                getTextLabel("Play \(rows)X3")
            }
        )
        .background(Color.white)
        .cornerRadius(25)
    }
    
    func getTextLabel(_ text:String) -> some View{
        return Text(text)
            .font(.largeTitle.bold())
            .frame(minWidth: 0, maxWidth: .infinity)
            .font(.system(size: 18))
            .padding()
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                getButton(3)
                getButton(4)
                getButton(5)
                getButton(6)
                getButton(7)
                .fullScreenCover(isPresented: $showingSheet, content: BoardView.init)
            }
            .padding(10)
            .frame(width: geometry.size.width,
                   height: geometry.size.height,
                   alignment: .center)
            .background(Rectangle().fill(ImagePaint(image: Image("wood1"), scale: 0.2)).shadow(radius: 0))
            //.position(x:geometry.size.width/2,y:geometry.size.height/2)
            //.border(ImagePaint(image: Image("wood4"), scale: 0.2), width: BOARDER_SIZE*2)
        }
        
    }
    /*var body: some View {
       TabView{
           BoardView()
               .tabItem(){
                   Image(systemName:"house")
                   //Text("SlidingNumbers")
               }
           
       }
       .accentColor(.black)
   }*/
    
}
    /*
     var body: some View {
        TabView{
            BoardView()
                .tabItem(){
                    Image(systemName:"house")
                    //Text("SlidingNumbers")
                }
            BoardView()
                .tabItem(){
                    Image(systemName:"person")
                    //Text("SlidingNumbers")
                }
            BoardView()
                .tabItem(){
                    Image(systemName:"contact")
                    //Text("SlidingNumbers")
                }
            /*ViewB()
                .tabItem(){
                    Image(systemName: "person.2.fill")
                    Text("Contacts")
                }*/
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
