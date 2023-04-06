//
//  BoardCell.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-01.
//

import SwiftUI

struct BoardCell:CellView,Identifiable{
    var isBoardCell: Bool
    var name: String
    var id: Int
    let size: (width:CGFloat,height:CGFloat)
    @EnvironmentObject var boardModel:BoardModel
    let dummy = Dummy()
    @State var index: Int
    @State private var location: CGPoint
    private var firstLocation: CGPoint
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
    
    func updatePosition(location:CGPoint){
        self.location = location
        self.baseLocation = location
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
                guard let dir = boardModel.isMoveable(self.index) else {
                    location = baseLocation
                    return
                }
                let newValues = boardModel.swapIfClosestToEmpty(
                    index:self.index,
                    baseLocation: baseLocation,
                    location: self.location)
                location = newValues.location
                baseLocation = newValues.location
                index = newValues.newIndex
            }
            .onChanged { value in
                //isHeld = true
                guard let dir = boardModel.isMoveable(self.index) else {
                    self.location = shakeAndStirLocation(value)
                    return
                }
                var newLocation = startLocation ?? location
                let emptyCell = boardModel.getEmptyCellLocation()
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
                guard let dir = boardModel.isMoveable(self.index) else {
                    return 
                }
                fingerLocation = value.location
            }
    }
    
    var baseCell: some View{
        Text(name)
            .foregroundColor(Color.white)
            .fixedSize(horizontal: false, vertical: true)
            .font(
                .custom(
                "AmericanTypewriter",
                fixedSize: 34)
                .weight(.semibold))
            .frame(width:size.width, height: size.height)
            .background(Rectangle().fill(ImagePaint(image: Image("wood1"), scale: 0.2)).shadow(radius: 0))
            .position(location)
            .gesture(
                simpleDrag
            )
            .onChange(of:boardModel.resetBoardCellLocation){ value in
                location = firstLocation
                baseLocation = firstLocation
                
                // on change get new location for empty cell
            }
            
    }
    
    var emptyCell: some View{
        //AnyView(EmptyView())
        Rectangle()
            .fill(.clear)
            .frame(width:size.width, height: size.height)
            .position(location)
            .onChange(of:boardModel.resetBoardCellLocation){ value in
                location = firstLocation
                baseLocation = firstLocation
            }
    }
    
    init(index:Int,
         value:Int,
         locationAndSize:(baseLocation:CGPoint,size: (width:CGFloat,height:CGFloat)),
         isBoardCell:Bool,
         updateCellLocation: (() -> Void)){
        self.isBoardCell = isBoardCell
        self.firstLocation = locationAndSize.baseLocation
        self.location = locationAndSize.baseLocation
        self.baseLocation = locationAndSize.baseLocation
        self.size = locationAndSize.size
        self.index = index
        self.name = "\(value)"
        self.id = index
        updateCellLocation()
    }
    
}
