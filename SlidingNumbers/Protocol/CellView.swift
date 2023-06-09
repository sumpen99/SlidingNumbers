//
//  CellView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-05.
//

import SwiftUI

protocol CellView: View {
    associatedtype BaseCell: View
    associatedtype EmptyCell: View
    
    var isBoardCell: Bool { get }
    
    var baseCell: BaseCell { get }
    
    var emptyCell: EmptyCell { get }
}

extension CellView {
    @ViewBuilder
    var body: some View {
        if isBoardCell {
            self.baseCell
        } else {
            self.emptyCell
        }
    }
}
