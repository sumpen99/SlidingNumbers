//
//  BoardCell.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-01.
//

import SwiftUI

struct BoardCell:CellView,Identifiable{
    var isBoardCell: Bool
    let name: String
    var id: String { name }
    let size: (width:CGFloat,height:CGFloat)
    //let cellSpace: (width:CGFloat,height:CGFloat)
    var position: (x:Int,y:Int)
    let boarderSize: CGFloat
    var zBase:CGFloat = 0.0
  
    @State var index: Int
    @State var isHeld:Bool = false
    @State private var location: CGPoint
    @State private var baseLocation: CGPoint
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    
    func swapLocation(newLocation:CGPoint){
        self.location = newLocation
        self.baseLocation = newLocation
    }
    
    func getLocation() -> CGPoint{
        return self.baseLocation
    }
    
    func shakeAndStirLocation(_ value:DragGesture.Value) -> CGPoint{
        var newLocation = baseLocation
        newLocation.x += min(0.5,max(-0.5,value.translation.width))
        newLocation.y += min(0.5,max(-0.5,value.translation.height))
        return newLocation
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onEnded {_ in 
                isHeld = false
                guard let dir = BoardModel.isMoveable(self.index) else {
                    location = baseLocation
                    return
                }
                let newValues = BoardModel.swapIfClosestToEmpty(
                    index:self.index,
                    baseLocation: baseLocation,
                    location: self.location)
                location = newValues.location
                baseLocation = location
                index = newValues.newIndex
            }
            .onChanged { value in
                isHeld = true
                guard let dir = BoardModel.isMoveable(self.index) else {
                    self.location = shakeAndStirLocation(value)
                    return
                }
                var newLocation = startLocation ?? location
                let emptyCell = BoardModel.getEmptyCellLocation()
                switch dir {
                    case .NORTH:
                        if value.translation.height > 0 {
                            self.location = shakeAndStirLocation(value)
                            return
                        }
                        else {
                            newLocation.y += value.translation.height
                            newLocation.y = max(newLocation.y,emptyCell.y)
                            
                        }
                    case .SOUTH:
                        if value.translation.height < 0 {
                            self.location = shakeAndStirLocation(value)
                            return
                        }
                        else {
                            newLocation.y += value.translation.height
                            newLocation.y = min(newLocation.y,emptyCell.y)
                        }
                    case .WEST:
                        if value.translation.width > 0 {
                            self.location = shakeAndStirLocation(value)
                            return
                        }
                        else {
                            newLocation.x += value.translation.width
                            newLocation.x = max(newLocation.x,emptyCell.x)
                        }
                    case .EAST:
                        if value.translation.width < 0 {
                            self.location = shakeAndStirLocation(value)
                            return
                        }
                        else {
                            newLocation.x += value.translation.width
                            newLocation.x = min(newLocation.x,emptyCell.x)
                        }
                }
                self.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
    }
    
    var fingerDrag: some Gesture {
        DragGesture(minimumDistance: 0)
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                guard let dir = BoardModel.isMoveable(self.index) else {
                    return 
                }
                fingerLocation = value.location
            }
    }
    
    var baseCell: some View{
        Text(name)
            .foregroundColor(Color.white)
            .fixedSize(horizontal: false, vertical: true)
            //.frame(minWidth: size.width,maxWidth: size.width, alignment: .center)
            .font(
                .custom(
                "AmericanTypewriter",
                fixedSize: 34)
                .weight(.semibold))
            //.multilineTextAlignment(.center)
            //.position(x:posX,y:posY)
            .frame(width:size.width, height: size.height)
            .background(Rectangle().fill(ImagePaint(image: Image("wood1"), scale: 0.2)).shadow(radius: 0))
            //.background(Image("wood3"))
            .position(location)
            .zIndex(isHeld ? 100 : 0)
            .gesture(
                //simpleDrag.simultaneously(with: fingerDrag)
                simpleDrag
            )
    }
    
    var emptyCell: some View{
        Rectangle()
            .fill(.clear)
            .frame(width:size.width, height: size.height)
            .position(location)
    }
    
    init(index:Int,
         position:(x:Int,y:Int),
         boardWidth:CGFloat,
         boardHeight:CGFloat,
         isBoardCell:Bool){
        self.index = index
        self.name = "\(index+1)"
        let cellSpace = BOARDER_CELL_SPACE
        let boarderSize = BOARDER_SIZE
        self.boarderSize = boarderSize
        let width = (boardWidth - boarderSize*2 - (cellSpace.width*CGFloat(BOARDER_COLS) + 1)) / CGFloat(BOARDER_COLS)
        let height = (boardHeight - boarderSize*2 - (cellSpace.height*CGFloat(BOARDER_ROWS) + 1)) / CGFloat(BOARDER_ROWS)
        let baseX = width/2 + boarderSize + (cellSpace.width * CGFloat(position.x)) + 1
        let baseY = height/2 + boarderSize + (cellSpace.height * CGFloat(position.y)) + 1
        let baseLocation = CGPoint(x:(baseX + (width*CGFloat(position.x))),
                                   y:(baseY + (height*CGFloat(position.y))))
        self.location = baseLocation
        self.baseLocation = baseLocation
        self.size = (width:width,height:height)
        self.position = position
        self.isBoardCell = isBoardCell
        BoardModel.addNewBoardMarker(index: index, location: baseLocation, isEmpty: !isBoardCell)
    }
   
}
