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
        boardModel.resetBoard()
        boardModel.regenerateBoard.toggle()
    }
    
    func navigateBack(){
        boardModel.clearBoard()
        dismiss()
    }
    
    var body: some View{
        VStack{
            HStack{
                Button(action: navigateBack, label: {
                    Text("Go Back")
                        .font(.subheadline.bold())
                        
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: reload, label: {
                    Text("Reload Board")
                        .font(.subheadline.bold())
                })
                .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            GeometryReader { geometry in
                ZStack() {
                    ForEach(boardModel.getMarkers(size:geometry.size), id: \.id) { marker in
                        BoardCell(cellMarker:marker)
                    }
                    
                }
                .environmentObject(boardModel)
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


