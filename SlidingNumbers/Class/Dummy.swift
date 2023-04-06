//
//  Dummy.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-05.
//

class Dummy{
    
    init(){
        //printAny("init dummy")
    }
    
    func printTest(){
        print(Unmanaged.passUnretained(self).toOpaque())
    }
    
    deinit{
        //printAny("deinit dummy")
    }
}
