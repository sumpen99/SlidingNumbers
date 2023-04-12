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
        /*DispatchQueue.main.async {
            for marker in self.boardMarkers{
          
                DispatchQueue.main.async {
                    marker.updateLocation()
                }
                
            }
        }*/
        
        for marker in self.boardMarkers{
            marker.updateLocation()
        }
    }
    
    func resetBoard(){
        var sum = 0
        var boardLayout = [Int]()
        emptyCellIndex = Int.random(in: 0..<BOARD_CELLS)
        randomCellGenerator(boardLayout:&boardLayout)
        if boardMarkers.isEmpty{
            for i in 0..<BOARD_CELLS{
                if boardLayout[i] == i+1 { sum+=1 }
                let isEmpty = i == emptyCellIndex
                let name = isEmpty ? "-1" : "\(boardLayout[i])"
                boardMarkers.append(BoardMarker(index:i,
                                                name:name,
                                                isEmpty: isEmpty))
            }
            
        }
        else{
            for i in 0..<BOARD_CELLS{
                if boardLayout[i] == i+1 { sum+=1 }
                let isEmpty = i == emptyCellIndex
                let name = isEmpty ? "-1" : "\(boardLayout[i])"
                boardMarkers.modifyElement(atIndex: i){
                    $0.index = i
                    $0.name = name
                    $0.isEmpty = isEmpty
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
        let oldEmptyCellIndex = emptyCellIndex
        let emptyCellLocation = boardMarkers[emptyCellIndex].baseLocation
        let newEmptyCellLocation = boardMarkers[index].baseLocation
        boardMarkers.modifyElement(atIndex: oldEmptyCellIndex){
            $0.index = index
            $0.location = newEmptyCellLocation
            $0.baseLocation = newEmptyCellLocation
        }
        
        boardMarkers.modifyElement(atIndex: index){
            $0.index = oldEmptyCellIndex
            $0.location = emptyCellLocation
            $0.baseLocation = emptyCellLocation
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
    
    deinit{
        printAny("deinit boardmodel")
    }
    
}
