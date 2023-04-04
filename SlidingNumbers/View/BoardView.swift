//
//  BoardView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-02.
//

import SwiftUI

struct BoardView: View{
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    var body: some View{
        GeometryReader { geometry in
            ZStack() {
                ForEach(0..<BOARD_CELLS,id: \.self) { index in
                    BoardCell(index:index,
                              position:(x:Int(index%BOARDER_COLS),
                                        y:Int(index/BOARDER_COLS)),
                              boardWidth:geometry.size.width,
                              boardHeight:geometry.size.height,
                              isBoardCell: index != 4)
                }
                
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height,
                   alignment: .topLeading)
            .border(ImagePaint(image: Image("wood1"), scale: 0.2), width: BOARDER_SIZE)
            .onAppear{
                printAny("on Appear BoardView \(safeAreaInsets.leading)")
                
            }
            .onDisappear{
                printAny("on Dissapear BoardView")
                
            }
        }
    }
    
    //init(){
        //printAny(UIScreen.screenWidth)
        //printAny(UIScreen.screenHeight)
        
        //printAny(safeAreaInsets)
        //printAny(UIScreen.screenHeight)
        //printAny(safeAreaInsets)
    //}
    
}


