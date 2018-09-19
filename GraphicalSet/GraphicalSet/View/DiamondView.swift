//
//  SquareView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/16/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class DiamondView: SetSymbolView {
    
    override init(frame: CGRect, fill: SetSymbolView.FillType, color: UIColor) {
        super.init(frame: frame, fill: fill, color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.percentMaxX(0.5), y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.percentMaxY(0.5)))
        path.addLine(to: CGPoint(x: rect.percentMaxX(0.5), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.percentMaxY(0.5)))
        path.close()
        path.addClip()
        
        if super.isStriped {
            super.drawStripes(bounds: rect, with: super.lineColor)
        } else if super.isSolid {
            super.lineColor.setFill()
            path.fill()
        }
        
        super.lineColor.setStroke()
        path.lineWidth = rect.percentMaxX(0.02)
        
        path.stroke()
    }
}
