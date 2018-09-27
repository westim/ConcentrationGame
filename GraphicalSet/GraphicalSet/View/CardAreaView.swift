//
//  CardAreaView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/25/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class CardAreaView: UIView {

    /// Cards in the play area
    var cards = [CardView]() { didSet { layoutSubviews() } }
    
    // Standard poker cards have aspect ratio of 2.5" : 3.5"
    private lazy var grid = Grid(layout: .aspectRatio(CGFloat(2.5 / 3.5)), frame: self.bounds)
    
}
