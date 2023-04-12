//
//  AppGlobal.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-01.
//
import SwiftUI

func printAny(_ msg: Any){
    print("\(msg)")
}

/*func address(o: UnsafeRawPointer) -> Int {
    return unsafeBitCast(o, to: Int.self)
}

func addressHeap<T: AnyObject>(o: T) -> Int {
    return unsafeBitCast(o, to: Int.self)
}*/

let DIFFICULT_LEVEL: Float = 0.5
var BOARDER_WIDTH: CGFloat = 0.0
var BOARDER_HEIGHT: CGFloat = 0.0
var CELL_WIDTH: CGFloat = 0.0
var CELL_HEIGHT: CGFloat = 0.0
var BOARDER_ROWS = 3
let BOARDER_COLS = 3
var BOARD_CELLS: Int { Int(BOARDER_ROWS)*Int(BOARDER_COLS)}
var BOARDER_SIZE: CGFloat{ return 30.0}
var BOARDER_CELL_SPACE: (width: CGFloat,height: CGFloat){ return (width:1.0,height:1.0)}

func setCellSize(width:CGFloat,height:CGFloat){
    BOARDER_WIDTH = width
    BOARDER_HEIGHT = height
    CELL_WIDTH = (BOARDER_WIDTH - BOARDER_SIZE*2 - (BOARDER_CELL_SPACE.width*CGFloat(BOARDER_COLS) + 1)) / CGFloat(BOARDER_COLS)
    CELL_HEIGHT = (BOARDER_HEIGHT - BOARDER_SIZE*2 - (BOARDER_CELL_SPACE.height*CGFloat(BOARDER_ROWS) + 1)) / CGFloat(BOARDER_ROWS)
}

func getCellLocation(position:(x:Int,y:Int)) -> CGPoint{
    let baseX = CELL_WIDTH/2 + BOARDER_SIZE + (BOARDER_CELL_SPACE.width * CGFloat(position.x)) + 1
    let baseY = CELL_HEIGHT/2 + BOARDER_SIZE + (BOARDER_CELL_SPACE.height * CGFloat(position.y)) + 1
    let baseLocation = CGPoint(x:(baseX + (CELL_WIDTH*CGFloat(position.x))),y:(baseY + (CELL_HEIGHT*CGFloat(position.y))))
    return baseLocation
}
