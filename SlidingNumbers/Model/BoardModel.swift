//
//  BoardModel.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-06.
//

import SwiftUI
class BoardModel: ObservableObject{
    var directions : [Direction] { return Direction.allValues}
    var boardMarkers = [BoardMarker]()
    var emptyCellIndex: Int = 0
    var randomEmptyCell: Int = 0
    var newEmptyCellLocation: CGPoint = CGPoint(x:0,y:0)
    @Published var resetBoardCellLocation : Bool = false
    
    func getNewBoardCell(index:Int,cellValue:(baseLocation:CGPoint,size: (width:CGFloat,height:CGFloat))) -> BoardCell{
        boardMarkers[index].location = cellValue.baseLocation
        let marker = boardMarkers[index]
        return BoardCell(index:index,
                         value:marker.value,
                         locationAndSize:cellValue,
                         isBoardCell: !marker.isEmpty)
    }
    
    func getMarkers() -> [BoardMarker] {
        randomCellGenerator()
        return boardMarkers
    }
    
    func randomCellGenerator(){
        boardMarkers.removeAll()
        emptyCellIndex = Int.random(in: 0..<BOARD_CELLS)
        var boardLayout = Int.getUniqueRandomNumbers(min: 1, max: BOARD_CELLS, count: BOARD_CELLS)
        let randomEmptyCellValue = boardLayout[emptyCellIndex]
        for i in 0..<boardLayout.count{
            if boardLayout[i] > randomEmptyCellValue{
                boardLayout[i] -= 1
            }
        }
        for i in 0..<BOARD_CELLS{
            boardMarkers.append(BoardMarker(
                index: i,
                value: emptyCellIndex == i ? -1 : boardLayout[i],
                location: CGPoint(x:0,y:0),
                isEmpty: emptyCellIndex == i))
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
        let c10 = boardMarkers[9]
        let c11 = boardMarkers[10]
        let c12 = boardMarkers[11]
        let c13 = boardMarkers[12]
        let c14 = boardMarkers[13]
        let c15 = boardMarkers[14]
        printAny("###################################")
        printAny("\(c1.toString()) \(c2.toString()) \(c3.toString())")
        printAny("\(c4.toString()) \(c5.toString()) \(c6.toString())")
        printAny("\(c7.toString()) \(c8.toString()) \(c9.toString())")
        printAny("\(c10.toString()) \(c11.toString()) \(c12.toString())")
        printAny("\(c13.toString()) \(c14.toString()) \(c15.toString())")
    }
    
    func swapWithEmpty(_ index: Int) -> (location:CGPoint,newIndex:Int){
        let oldEmptyCellIndex = emptyCellIndex
        let emptyCellLocation = boardMarkers[emptyCellIndex].location
        newEmptyCellLocation = boardMarkers[index].location
       
        let value = boardMarkers[index].value
        
        emptyCellIndex = index
        
        boardMarkers.modifyElement(atIndex: oldEmptyCellIndex){
            $0.value = value
            $0.isEmpty = false
        }
        
        boardMarkers.modifyElement(atIndex: index){
            $0.value = -1
            $0.isEmpty = true
        }
        return (location:emptyCellLocation,newIndex:oldEmptyCellIndex)
    }
 
    func getEmptyCellLocation() -> CGPoint{
        return boardMarkers[emptyCellIndex].location
    }
    
    func swapIfClosestToEmpty(index:Int,baseLocation:CGPoint,location:CGPoint) -> (location:CGPoint,newIndex:Int){
        let emptyCellLocation = boardMarkers[emptyCellIndex].location
        let d1 = sqrt(pow(emptyCellLocation.x - location.x, 2) + pow(emptyCellLocation.y - location.y, 2) * 1.0)
        let d2 = sqrt(pow(baseLocation.x - location.x, 2) + pow(baseLocation.y - location.y, 2) * 1.0)
        
        if d1 < d2{
            return swapWithEmpty(index)
        }
        
        return (location:baseLocation,newIndex:index)
    }
    
}
