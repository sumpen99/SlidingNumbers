//
//  BoardView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-02.
//

import SwiftUI

struct BoardView: View{
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isPresented) private var isPresented
    @StateObject var boardModel = BoardModel()
   
    func reload(){
        boardModel.resetBoardCellLocation.toggle()
    }
    
    func getBaseLocation(size:CGSize,position:(x:Int,y:Int)) -> (baseLocation:CGPoint,size: (width:CGFloat,height:CGFloat)){
        let cellSpace = BOARDER_CELL_SPACE
        let boarderSize = BOARDER_SIZE
        let width = (size.width - boarderSize*2 - (cellSpace.width*CGFloat(BOARDER_COLS) + 1)) / CGFloat(BOARDER_COLS)
        let height = (size.height - boarderSize*2 - (cellSpace.height*CGFloat(BOARDER_ROWS) + 1)) / CGFloat(BOARDER_ROWS)
        let baseX = width/2 + boarderSize + (cellSpace.width * CGFloat(position.x)) + 1
        let baseY = height/2 + boarderSize + (cellSpace.height * CGFloat(position.y)) + 1
        let baseLocation = CGPoint(x:(baseX + (width*CGFloat(position.x))),
                                   y:(baseY + (height*CGFloat(position.y))))
        return (baseLocation:baseLocation,size:(width:width,height:height))
    }
    
    var body: some View{
        VStack{
            Button(action: reload, label: {
                Text("NewGame")
            })
            GeometryReader { geometry in
                ZStack() {
                    ForEach(boardModel.getMarkers(), id: \.id) { marker in
                        let cellValue = getBaseLocation(size:geometry.size,
                                                              position:
                                                                (x:Int(marker.index%BOARDER_COLS),
                                                                 y:Int(marker.index/BOARDER_COLS)))
                        boardModel.getNewBoardCell(index: marker.index, cellValue: cellValue)
                        .environmentObject(boardModel)
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
        .padding(20)
        
    }
    
    
}


