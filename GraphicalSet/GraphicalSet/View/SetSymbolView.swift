//
//  SetSymbol.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/16/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class SetSymbolView: UIView {
    var isStriped = false
    var isSolid = false
    var lineColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    init(frame: CGRect, fill: SetSymbolView.FillType, color: UIColor) {
        lineColor = color
        switch(fill) {
        case .stripe:
            isStriped = true
        case .solid:
            isSolid = true
        case .none:
            break
        }
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    func drawStripes(bounds: CGRect, with color: UIColor) {
        for x in stride(from: 0, to: 1, by: 0.1) {
            let line = UIBezierPath()
            line.lineWidth = 0.05 * bounds.maxX
            line.move(to: bounds.getPoint(x: CGFloat(x), y: 0))
            line.addLine(to: bounds.getPoint(x: CGFloat(x), y: 1))
            color.setStroke()
            line.stroke()
        }
    }
    
    enum FillType {
        case stripe, solid, none
    }
}
