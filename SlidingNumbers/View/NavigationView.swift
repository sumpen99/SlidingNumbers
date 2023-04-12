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
}
