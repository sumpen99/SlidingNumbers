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

/*
 
 func getCellLocationAndSize(position:(x:Int,y:Int)) -> (baseLocation:CGPoint,size:(width:CGFloat,height:CGFloat)){
     let baseX = CELL_WIDTH/2 + BOARDER_SIZE + (BOARDER_CELL_SPACE.width * CGFloat(position.x)) + 1
     let baseY = CELL_HEIGHT/2 + BOARDER_SIZE + (BOARDER_CELL_SPACE.height * CGFloat(position.y)) + 1
     let baseLocation = CGPoint(x:(baseX + (CELL_WIDTH*CGFloat(position.x))),y:(baseY + (CELL_HEIGHT*CGFloat(position.y))))
     return (baseLocation:baseLocation,size:(width:CELL_WIDTH,height:CELL_HEIGHT))
 }
 
 private struct SafeAreaInsetsEnvironmentKey: EnvironmentKey {
    static let defaultValue: (top: CGFloat, bottom: CGFloat) = (0, 0)
}

extension EnvironmentValues {
    var safeAreaInsets: (top: CGFloat, bottom: CGFloat) {
        get { self[SafeAreaInsetsEnvironmentKey.self] }
        set { self[SafeAreaInsetsEnvironmentKey.self] = newValue }
    }
}*/

//testings.modifyElement(atIndex: 0) { $0.value = 99 }
//testings.modifyForEach { $1.value *= 2 }
//testings.modifyForEach { $1.value = $0 }

extension Array {
    mutating func modifyForEach(_ body: (_ index: Index, _ element: inout Element) -> ()) {
        for index in indices {
            modifyElement(atIndex: index) { body(index, &$0) }
        }
    }

    mutating func modifyElement(atIndex index: Index, _ modifyElement: (_ element: inout Element) -> ()) {
        var element = self[index]
        modifyElement(&element)
        self[index] = element
    }
}

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

private struct SafeAreaInsetsKey:EnvironmentKey {
    
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
