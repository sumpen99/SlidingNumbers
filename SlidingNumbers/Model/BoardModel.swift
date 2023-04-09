//
//  BoardModel.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-06.
//

import SwiftUI

class BoardModel: ObservableObject{
    @Published var regenerateBoard : Bool = false
    var directions : [Direction] { return Direction.allValues}
    var boardMarkers = [BoardMarker]()
    var emptyCellIndex: Int = 0
    var boardLayout = [Int]()
    
    deinit{
        printAny("deinit boardmodel")
    }
    
    func clearBoard(){
        printAny("clear board")
        boardMarkers.removeAll()
    }
    
    func getMarkers(width:CGFloat,height:CGFloat) -> [BoardMarker] {
        setCellSize(width:width,height:height)
        if boardMarkers.isEmpty { resetBoard() }
        else { updateBoardCells()}
        return boardMarkers
    }
    
    func resetBoard(){
        var sum = 0
        emptyCellIndex = Int.random(in: 0..<BOARD_CELLS)
        randomCellGenerator()
        if boardMarkers.isEmpty{ addMarkersToBoard(sum:&sum) }
        else{ refreshMarkersOnBoard(sum:&sum) }
        if sum == BOARD_CELLS-1 { resetBoard()}
        boardLayout.removeAll()
    }
    
    func updateBoardCells(){
        for marker in boardMarkers{
            marker.updateID()
            marker.updateLocation()
        }
    }
   
    func randomCellGenerator(){
        boardLayout = Int.getUniqueRandomNumbers(min: 1, max: BOARD_CELLS, count: BOARD_CELLS)
        let randomEmptyCellValue = boardLayout[emptyCellIndex]
        for i in 0..<boardLayout.count{
            if boardLayout[i] > randomEmptyCellValue{
                boardLayout[i] -= 1
            }
        }
    }
    
    func addMarkersToBoard(sum: inout Int){
        var sum = 0
        for i in 0..<BOARD_CELLS{
            if boardLayout[i] == i+1 { sum+=1 }
            let isEmpty = i == emptyCellIndex
            boardMarkers.append(BoardMarker(index:i,
                                            name:isEmpty ? "-1" : "\(boardLayout[i])",
                                            isEmpty: isEmpty))
        }
        if sum == BOARD_CELLS-1 { randomCellGenerator()}
    }
    
    func refreshMarkersOnBoard(sum: inout Int){
        for i in 0..<BOARD_CELLS{
            if boardLayout[i] == i+1 { sum+=1 }
            let isEmpty = i == emptyCellIndex
            boardMarkers.modifyElement(atIndex: i){
                $0.index = i
                $0.name = isEmpty ? "-1" : "\(boardLayout[i])"
                $0.isEmpty = isEmpty
            }
        }
    }
    
    
    func isMoveable(_ index: Int)->Direction?{
        return searchBoard(index)
    }
    
    func validIndex(_ index:Int) -> Bool{
        return index >= 0 && index < BOARD_CELLS
    }
    
    func getIndex(row:Int,col:Int) -> Int{
        if !validRowCol(row: row, col: col) { return -1}
        return row*BOARDER_COLS + col
    }
    
    func validRowCol(row:Int,col:Int) ->Bool {
        return (row >= 0 && row < BOARDER_ROWS) && (col >= 0 && col < BOARDER_COLS)
    }
    
    func getRowFromIndex(_ index:Int) -> Int{
        return index / BOARDER_COLS
    }
    
    func getColFromIndex(_ index:Int) -> Int{
        return index % BOARDER_COLS
    }
    
    func searchBoard(_ index:Int) -> Direction?{
        for i in 0..<directions.count{
            var row = getRowFromIndex(index)
            var col = getColFromIndex(index)
            if searchDirection(row: &row, col: &col, dir: directions[i]){ return directions[i]}
        }
        return nil
    }
    
    func searchDirection(row: inout Int,col: inout Int,dir:Direction) -> Bool{
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
    
 
    func getEmptyCellLocation() -> CGPoint{
        return boardMarkers[emptyCellIndex].location
    }
    
    func swapIfClosestToEmpty(index:Int,baseLocation:CGPoint,location:CGPoint){
        let emptyCellLocation = boardMarkers[emptyCellIndex].location
        let d1 = sqrt(pow(emptyCellLocation.x - location.x, 2) + pow(emptyCellLocation.y - location.y, 2) * 1.0)
        let d2 = sqrt(pow(baseLocation.x - location.x, 2) + pow(baseLocation.y - location.y, 2) * 1.0)
        
        if d1 < d2{
            swapWithEmpty(index)
            return
        }
        
        boardMarkers.modifyElement(atIndex: index){
            $0.location = baseLocation
            $0.regenerateLocation.toggle()
        }
    }
    
    func swapWithEmpty(_ index: Int){
        let oldEmptyCellIndex = emptyCellIndex
        let emptyCellLocation = boardMarkers[emptyCellIndex].location
        let newEmptyCellLocation = boardMarkers[index].location
        boardMarkers.modifyElement(atIndex: oldEmptyCellIndex){
            $0.index = index
            $0.location = newEmptyCellLocation
            $0.regenerateLocation.toggle()
        }
        
        boardMarkers.modifyElement(atIndex: index){
            $0.index = oldEmptyCellIndex
            $0.location = emptyCellLocation
            $0.regenerateLocation.toggle()
        }
        
        boardMarkers.swapAt(index, oldEmptyCellIndex)
        emptyCellIndex = index
    }
    
    func printCurrentBoard(){
        let c1 = boardMarkers[0]
        let c2 = boardMarkers[1]
        let c3 = boardMarkers[2]
        let c4 = boardMarkers[3]
        let c5 = boardMarkers[4]
        let c6 = boardMarkers[5]
        let c7 = boardMarkers[6]
        let c8 = boardMarkers[7]
        let c9 = boardMarkers[8]
        /*let c10 = boardMarkers[9]
        let c11 = boardMarkers[10]
        let c12 = boardMarkers[11]
        let c13 = boardMarkers[12]
        let c14 = boardMarkers[13]
        let c15 = boardMarkers[14]*/
        printAny("###################################")
        printAny("\(c1.toString()) \(c2.toString()) \(c3.toString())")
        printAny("\(c4.toString()) \(c5.toString()) \(c6.toString())")
        printAny("\(c7.toString()) \(c8.toString()) \(c9.toString())")
        //printAny("\(c10.toString()) \(c11.toString()) \(c12.toString())")
        //printAny("\(c13.toString()) \(c14.toString()) \(c15.toString())")
    }
    
}
