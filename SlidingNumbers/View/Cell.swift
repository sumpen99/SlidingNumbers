//
//  Cell.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-02.
//

import SwiftUI

protocol CellView: View {
    associatedtype BaseCell: View
    associatedtype EmptyCell: View
    
    var isBoardCell: Bool { get set }
    
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
