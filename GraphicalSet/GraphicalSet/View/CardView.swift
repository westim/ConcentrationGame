//
//  CardView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/21/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIButton {
    
    private(set) var count: Int
    private(set) var color: UIColor
    private(set) var fill: SetSymbolView.FillType
    private(set) var symbol: SetSymbolView
    
    func setup<T: SetSymbolView>(symbol: T, count: Int, fill: T.FillType, color: UIColor) {
        self.layer.cornerRadius = self.bounds.width / 4
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        self.symbol = symbol
        self.count = count
        self.fill = fill
        self.color = color
    }
    
    init(frame: CGRect, symbol: SetSymbolView, count: Int, fill: SetSymbolView.FillType, color: UIColor) {
        super.init(frame: frame)
        setup(symbol: symbol, count: count, fill: fill, color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
