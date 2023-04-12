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
    
    func getMarkers(width:CGFloat,height:CGFloat) -> [BoardMarker] {
        setCellSize(width:width,height:height)
        if boardMarkers.isEmpty { resetBoard() }
        else { updateBoardCells()}
        return boardMarkers
    }
    
    func updateBoardCells(){
        printAny("################## START DEVICE ROTATION ##########################")
        for marker in self.boardMarkers{
            DispatchQueue.main.async {
                marker.updateLocation()
            }
        }
        /*for marker in self.boardMarkers{
            marker.updateLocation()
        }*/
    }
    
    func resetBoard(){
        var sum = 0
        var boardLayout = [Int]()
        emptyCellIndex = Int.random(in: 0..<BOARD_CELLS)
        randomCellGenerator(boardLayout:&boardLayout)
        if boardMarkers.isEmpty{
            for i in 0..<BOARD_CELLS{
                if boardLayout[i] == i+1 { sum+=1 }
                let isBoardCell = i != emptyCellIndex
                let name = isBoardCell ? "\(boardLayout[i])" : EMPTY_CELL_IDENTIFIER
                boardMarkers.append(BoardMarker(index:i,
                                                name:name))
            }
            
        }
        else{
            for i in 0..<BOARD_CELLS{
                if boardLayout[i] == i+1 { sum+=1 }
                let isBoardCell = i != emptyCellIndex
                let name = isBoardCell ? "\(boardLayout[i])" : EMPTY_CELL_IDENTIFIER
                boardMarkers.modifyElement(atIndex: i){
                    $0.index = i
                    $0.name = name
                }
            }
            
        }
        let value = Float(sum) / Float(BOARD_CELLS-1)
        if value > DIFFICULT_LEVEL { resetBoard() }
    }
   
    func randomCellGenerator(boardLayout: inout [Int]){
        boardLayout = Int.getUniqueRandomNumbers(min: 1, max: BOARD_CELLS, count: BOARD_CELLS)
        let randomEmptyCellValue = boardLayout[emptyCellIndex]
        for i in 0..<boardLayout.count{
            if boardLayout[i] > randomEmptyCellValue{
                boardLayout[i] -= 1
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
    
    func swapIfClosestToEmpty(index:Int){
        let baseLocation = boardMarkers[index].baseLocation
        let location = boardMarkers[index].location
        let emptyCellLocation = boardMarkers[emptyCellIndex].baseLocation
        
        let d1 = sqrt(pow(emptyCellLocation.x - location.x, 2) + pow(emptyCellLocation.y - location.y, 2) * 1.0)
        let d2 = sqrt(pow(baseLocation.x - location.x, 2) + pow(baseLocation.y - location.y, 2) * 1.0)
        
        if d1 < d2{
            swapWithEmpty(index)
            return
        }
                
        boardMarkers[index].resetLocationToBase()
    }
    
    func swapWithEmpty(_ index: Int){
        let emptyCellLocation = boardMarkers[emptyCellIndex].baseLocation
        let newEmptyCellLocation = boardMarkers[index].baseLocation
        boardMarkers.modifyElement(atIndex: emptyCellIndex){
            $0.index = index
            $0.location = newEmptyCellLocation
            $0.baseLocation = newEmptyCellLocation
        }
        
        boardMarkers.modifyElement(atIndex: index){
            $0.index = emptyCellIndex
            $0.location = emptyCellLocation
            $0.baseLocation = emptyCellLocation
        }
        
        boardMarkers.swapAt(index, emptyCellIndex)
        emptyCellIndex = index
    }
    
    deinit{
        printAny("deinit boardmodel")
    }
    
}
