//
//  BoardMarker.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-03.
//

import Foundation

class BoardMarker:Identifiable{
    var id: Int
    var index: Int
    var value:Int
    var location: CGPoint
    var isEmpty: Bool
     
    /*convenience init(){
        self.init(index: 0,value: -1, location: CGPoint(x:0,y:0), isEmpty: false)
    }*/
    
    init(index: Int,value:Int,location: CGPoint,isEmpty:Bool){
        self.id = index
        self.index = index
        self.value = value
        self.location = location
        self.isEmpty = isEmpty
    }
}
