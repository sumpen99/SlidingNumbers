//
//  BoardCell.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-01.
//
import SwiftUI

struct BoardCell:CellView{
    @EnvironmentObject var boardModel:BoardModel
    @ObservedObject var cellMarker:BoardMarker
  
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    
    var dummy = Dummy()
    var isBoardCell: Bool { !cellMarker.isEmpty}
    
    func shakeAndBakeLocation(_ value:DragGesture.Value) {
        var newLocation = cellMarker.baseLocation
        newLocation.x += min(0.5,max(-0.5,value.translation.width))
        newLocation.y += min(0.5,max(-0.5,value.translation.height))
        cellMarker.location = newLocation
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onEnded {_ in
                guard boardModel.isMoveable(cellMarker.index) != nil else {
                    cellMarker.resetLocationToBase()
                    return
                }
                boardModel.swapIfClosestToEmpty(
                    index:cellMarker.index)
            }
            .onChanged { value in
                guard let dir = boardModel.isMoveable(cellMarker.index) else {
                    shakeAndBakeLocation(value)
                    return
                }
                var newLocation = startLocation ?? cellMarker.location
                let emptyCell = boardModel.getEmptyCellLocation()
                switch dir {
                case .NORTH:
                    if value.translation.height > 0 {
                        shakeAndBakeLocation(value)
                        return
                    }
                    else {
                        newLocation.y += value.translation.height
                        newLocation.y = max(newLocation.y,emptyCell.y)
                        
                    }
                case .SOUTH:
                    if value.translation.height < 0 {
                        shakeAndBakeLocation(value)
                        return
                    }
                    else {
                        newLocation.y += value.translation.height
                        newLocation.y = min(newLocation.y,emptyCell.y)
                    }
                case .WEST:
                    if value.translation.width > 0 {
                        shakeAndBakeLocation(value)
                        return
                    }
                    else {
                        newLocation.x += value.translation.width
                        newLocation.x = max(newLocation.x,emptyCell.x)
                    }
                case .EAST:
                    if value.translation.width < 0 {
                        shakeAndBakeLocation(value)
                        return
                    }
                    else {
                        newLocation.x += value.translation.width
                        newLocation.x = min(newLocation.x,emptyCell.x)
                    }
                }
                cellMarker.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? cellMarker.location
            }
    }
    
    var baseCell: some View{
        Text(cellMarker.name)
            .foregroundColor(Color.white)
            .fixedSize(horizontal: false, vertical: true)
            .font(
                .custom(
                    "AmericanTypewriter",
                    fixedSize: 34)
                .weight(.semibold))
            .frame(width:CELL_WIDTH, height: CELL_HEIGHT)
            //.background(Rectangle().fill(ImagePaint(image: Image("wood1"), scale: 0.2)).shadow(radius: 0))
            .background(Rectangle().fill(ImagePaint(image: Image("wood1"), scale: 0.2)))
            .position(cellMarker.location)
            .gesture(
                simpleDrag
            )
            .onDisappear(){
                printAny("boardcell will disappear")
                //self.cellMarker.printReferenceCount()
            }
    }
    
    var emptyCell: some View{
        Rectangle()
            .fill(.blue)
            .frame(width:CELL_WIDTH, height: CELL_HEIGHT)
            .position(cellMarker.location)
            .onDisappear(){
                printAny("boardcell will disappear")
                //self.cellMarker.printReferenceCount()
            }
    }
    
    init(cellMarker:BoardMarker){
        self.cellMarker = cellMarker
        dummy.name = self.cellMarker.id.uuidString
        printAny("################ INIT BOARDCELL ############################")
    }
    
}
