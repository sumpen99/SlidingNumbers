//
//  GameMenuView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-13.
//

import SwiftUI

struct GameMenuView: View{
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
            .font(.subheadline.bold())
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
        ZStack{
            RatioContainer(widthRatio: 0.5){
                ScrollView{
                    VStack{
                        getButton(3)
                        getButton(4)
                        getButton(5)
                        getButton(6)
                        getButton(7)
                        //.sheet(isPresented: $showingSheet, content: BoardView.init)
                            .fullScreenCover(isPresented: $showingSheet, content: BoardView.init)
                    }
                    .padding(10)
                }
            }
        }
        .background(Rectangle().fill(WOOD_IMAGE_PAINT).shadow(radius: 0).edgesIgnoringSafeArea(.all))
            
    }
}
