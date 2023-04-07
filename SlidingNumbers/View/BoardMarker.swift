//
//  BoardMarker.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-03.
//

import Foundation

class BoardMarker:Identifiable{
    let id = UUID()
    var index: Int
    var value:Int
    var location: CGPoint
    var isEmpty: Bool
    
    init(index: Int,value:Int,location: CGPoint,isEmpty:Bool){
        self.index = index
        self.value = value
        self.location = location
        self.isEmpty = isEmpty
    }
    
    func toString() -> String{
        return "(\(index) \(value))"
    }
}
