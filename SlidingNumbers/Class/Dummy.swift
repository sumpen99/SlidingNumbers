//
//  Dummy.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-05.
//

class Dummy{
    var name = ""
    var printOnDestroy = false
    init(name:String = "",printOnDestroy:Bool = false){
        self.name = name
        self.printOnDestroy = printOnDestroy
    }
    
    func printTest(){
        print(Unmanaged.passUnretained(self).toOpaque())
    }
    
    deinit{
        if printOnDestroy{
            printAny("deinit dummy name: \(name)")
        }
    }
}
