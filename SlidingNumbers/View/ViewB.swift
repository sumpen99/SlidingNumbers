//
//  ViewB.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-05.
//

import SwiftUI

struct ViewB:View{
    var body: some View{
        ZStack{
            Color.blue
            Image(systemName:"person.2.fill")
                .foregroundColor(Color.white)
                .font(.system(size:100.0))
        }
    }
    
}

struct ViewB_Previews:PreviewProvider{
    static var previews:some View{
        ViewB()
    }
}
