//
//  CardAreaView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/25/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class CardAreaView: UIView {

    /// Cards in the play area.
    private(set) var cards = [CardView]() { didSet { resizeGrid(); layoutSubviews() } }
    
    func add(_ card: CardView) {
        addSubview(card)
        cards.append(card)
    }
    
    private lazy var grid = Grid(layout: .aspectRatio(SizeRatio.cardAspectRatio), frame: self.bounds)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for index in 0..<cards.count {
            cards[index].sizeThatFits(grid.cellSize)
            
            // Force unwrapping because grid.cellCount == cards.count
            cards[index].frame = grid[index]!
        }
    }
    
    /**
     Ensures the grid has the same number of cells
     as the current card count.
     */
    private func resizeGrid() {
        grid.cellCount = cards.count
    }
}

// MARK: Constants

private extension CardAreaView {
    private struct SizeRatio {
        
        /// Standard poker cards have aspect ratio of 2.5" : 3.5"
        static let cardAspectRatio: CGFloat = 2.5 / 3.5
    }
}