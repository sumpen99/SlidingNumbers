//
//  BoardMarker.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-03.
//
import SwiftUI

class BoardMarker:Identifiable,ObservableObject{
    @Published var location = CGPoint(x:0,y:0)
    var baseLocation = CGPoint(x:0,y:0)
    let id = UUID()
    var index: Int
    var name:String
    var isEmpty: Bool
    
    deinit{
        printAny("deinit boardmarker \(id)")
    }
    
    init(index: Int,name:String,isEmpty:Bool){
        self.index = index
        self.name = name
        self.isEmpty = isEmpty
        updateLocation()
    }
    
    func updateLocation(){
        let position = (x:Int(index%BOARDER_COLS),y:Int(index/BOARDER_COLS))
        self.location = getCellLocation(position:position)
        self.baseLocation = getCellLocation(position:position)
    }
    
    func resetLocationToBase(){
        self.location = self.baseLocation
    }
    
    func printReferenceCount(){
        printAny("ReferenceCount to -> \(id.uuidString) = \(CFGetRetainCount(self)) isEmptyCell: \(isEmpty)")
    }
   
    func toString() -> String{
        return "(\(index) \(name))"
    }
}
