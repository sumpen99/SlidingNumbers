//
//  BoardMarker.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-03.
//
import SwiftUI

class BoardMarker:Identifiable,ObservableObject{
    @Published var regenerateLocation : Bool = false
    var id = UUID()
    var index: Int
    var name:String
    var isEmpty: Bool
    var _location: CGPoint = CGPoint(x:0,y:0)
    var location: CGPoint {
          get {
            return _location
          }
          set (newVal) {
            _location = newVal
        }
    }
    
    deinit{
        printAny("deinit boardmarker \(id)")
    }
    
    init(index: Int,name:String,isEmpty:Bool){
        self.index = index
        self.name = name
        self.isEmpty = isEmpty
        updateLocation()
    }
    
    func updateID(){
        id = UUID()
    }
    
    func updateLocation(){
        let position = (x:Int(index%BOARDER_COLS),y:Int(index/BOARDER_COLS))
        self.location = getCellLocation(position:position)
    }
   
    func toString() -> String{
        return "(\(index) \(name))"
    }
}
