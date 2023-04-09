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
    var _width: CGFloat = 0.0
    var _height: CGFloat = 0.0
    var location: CGPoint {
          get {
            return _location
          }
          set (newVal) {
            _location = newVal
        }
    }
    var width: CGFloat {
          get {
            return _width
          }
          set (newVal) {
            _width = newVal
        }
    }
    var height: CGFloat {
          get {
            return _height
          }
          set (newVal) {
            _height = newVal
        }
    }
    
    deinit{
        printAny("deinit boardmarker \(id)")
    }
    
    init(index: Int,name:String,isEmpty:Bool){
        self.index = index
        self.name = name
        self.isEmpty = isEmpty
        
        updateSizeAndLocation()
    }
    
    func updateID(){
        id = UUID()
    }
    
    func updateSizeAndLocation(){
        let position = (x:Int(index%BOARDER_COLS),y:Int(index/BOARDER_COLS))
        let cellValue = getCellLocationAndSize(position:position)
        
        self.location = cellValue.baseLocation
        self.width = cellValue.size.width
        self.height = cellValue.size.height
    }
   
    func toString() -> String{
        return "(\(index) \(name))"
    }
}
