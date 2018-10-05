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
    var lineColor = UIColor.black
    
    required init(frame: CGRect, fill: SetSymbolView.FillType, color: UIColor) {
        super.init(frame: frame)
        lineColor = color
        switch(fill) {
        case .stripe:
            isStriped = true
        case .solid:
            isSolid = true
        case .none:
            break
        }
        backgroundColor = UIColor.transparent
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawStripes(bounds: CGRect, with color: UIColor) {
        for x in stride(from: 0, to: 1, by: 0.1) {
            let line = UIBezierPath()
            line.lineWidth = Ratio.lineWidthToSize * bounds.maxX
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

extension SetSymbolView {
    struct Ratio {
        static let lineWidthToSize: CGFloat = 0.05
    }
}
