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
    var cards: [CardView] {
        return self.subviews as! [CardView]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func add(_ newCards: [CardView]) {
        newCards.forEach { self.addSubview($0) }
        resizeGrid()
        newCards.forEach { $0.setup() }
    }
    
    private lazy var grid = Grid(layout: .aspectRatio(SizeRatio.cardAspectRatio), frame: self.bounds)
    
    private func resizeGrid() {
        grid.cellCount = cards.count
        for index in 0..<cards.count {
            cards[index].frame = grid[index]!
        }
    }
}

// MARK: Constants

private extension CardAreaView {
    private struct SizeRatio {
        
        /// Standard poker cards aspect ratio of 2.5" : 3.5"
        static let cardAspectRatio: CGFloat = 2.5 / 3.5
    }
}
