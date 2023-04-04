//
//  BoardModel.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-02.
//

import Foundation

class BoardModel{
    static var directions : [Direction] { return Direction.allValues}
    static var boardCells = [BoardMarker]()
    static var emptyCellIndex: Int = 0
    
    static func isMoveable(_ index: Int)->Direction?{
        return searchBoard(index)
    }
    
    static func validIndex(_ index:Int) -> Bool{
        return index >= 0 && index < BOARD_CELLS
        
    }
    
    static func getIndex(row:Int,col:Int) -> Int{
        if !validRowCol(row: row, col: col) { return -1}
        return row*BOARDER_COLS + col
    }
    
    static func validRowCol(row:Int,col:Int) ->Bool {
        return (row >= 0 && row < BOARDER_ROWS) && (col >= 0 && col < BOARDER_COLS)
    }
    
    static func getRowFromIndex(_ index:Int) -> Int{
        return index / BOARDER_COLS
    }
    
    static func getColFromIndex(_ index:Int) -> Int{
        return index % BOARDER_COLS
    }
    
    static func searchBoard(_ index:Int) -> Direction?{
        for i in 0..<directions.count{
            var row = getRowFromIndex(index)
            var col = getColFromIndex(index)
            if searchDirection(row: &row, col: &col, dir: directions[i]){ return directions[i]}
        }
        return nil
    }
    
    static func searchDirection(row: inout Int,col: inout Int,dir:Direction) -> Bool{
        switch dir {
            case .NORTH:
                row -= 1
            case .SOUTH:
                row += 1
            case .EAST:
                col += 1
            case .WEST:
                col -= 1
        }
        
        let index = getIndex(row: row, col: col)
        return index == emptyCellIndex
    }
    
    static func swapWithEmpty(_ index: Int) -> (location:CGPoint,newIndex:Int){
        let oldEmptyCellIndex = emptyCellIndex
        let emptyCellLocation = boardCells[emptyCellIndex].location
        emptyCellIndex = index
        
        
        boardCells.modifyElement(atIndex: oldEmptyCellIndex){
            $0.isEmpty = false
        }
        
        boardCells.modifyElement(atIndex: index){
            $0.isEmpty = true
        }
   
        return (location:emptyCellLocation,newIndex:oldEmptyCellIndex)
    }
    
    static func getEmptyCellLocation() -> CGPoint{
        return boardCells[emptyCellIndex].location
    }
    
    static func swapIfClosestToEmpty(index:Int,baseLocation:CGPoint,location:CGPoint) -> (location:CGPoint,newIndex:Int){
        let emptyCellLocation = boardCells[emptyCellIndex].location
        let d1 = sqrt(pow(emptyCellLocation.x - location.x, 2) + pow(emptyCellLocation.y - location.y, 2) * 1.0)
        let d2 = sqrt(pow(baseLocation.x - location.x, 2) + pow(baseLocation.y - location.y, 2) * 1.0)
        
        printAny("\(d1) \(d2)")
        
        if d1 < d2{
            return swapWithEmpty(index)
        }
        
        return (location:baseLocation,newIndex:index)
    }
    
    static func addNewBoardMarker(index:Int,location:CGPoint,isEmpty:Bool){
        if boardCells.count == index + 1{
            return
        }
        else{
            boardCells.append(BoardMarker(
                                index: index,
                                location: location,
                                isEmpty: isEmpty))
        }
        if isEmpty{
            emptyCellIndex = index
        }
    }
    
}
