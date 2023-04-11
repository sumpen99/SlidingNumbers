//
//  Dummy.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-05.
//

class Dummy{
    var name = ""
    init(){
        //printAny("init dummy")
    }
    
    func printTest(){
        print(Unmanaged.passUnretained(self).toOpaque())
    }
    
    deinit{
        //printAny("deinit dummy name: \(name)")
    }
}
