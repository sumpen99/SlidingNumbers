//
//  BoardMarker.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-03.
//

import Foundation

struct BoardMarker{
    var index: Int
    var location: CGPoint
    var isEmpty: Bool
    
    init(){
        self.init(index: 0, location: CGPoint(x:0,y:0), isEmpty: false)
    }
    
    init(index: Int,location: CGPoint,isEmpty:Bool){
        self.index = index
        self.location = location
        self.isEmpty = isEmpty
    }
}
