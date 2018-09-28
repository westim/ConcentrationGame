//
//  SquiggleView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/16/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class SquiggleView: SetSymbolView {
    
    required init(frame: CGRect, fill: SetSymbolView.FillType, color: UIColor) {
        super.init(frame: frame, fill: fill, color: color)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: rect.getPoint(x: 0.2, y: 0.05))
        path.addCurve(to: rect.getPoint(x: 0.7, y: 0.2), controlPoint1: rect.getPoint(x: 0.3, y: 0), controlPoint2: rect.getPoint(x: 0.5, y: 0.2))
        path.addCurve(to: rect.getPoint(x: 0.95, y: 0.15), controlPoint1: rect.getPoint(x: 0.8, y: 0.2), controlPoint2: rect.getPoint(x: 0.9, y: -0.1))
        path.addCurve(to: rect.getPoint(x: 0.8, y: 0.95), controlPoint1: rect.getPoint(x: 1.05, y: 0.6), controlPoint2: rect.getPoint(x: 0.9, y: 0.9))
        
        path.addCurve(to: rect.getPoint(x: 0.3, y: 0.8), controlPoint1: rect.getPoint(x: 0.7, y: 1), controlPoint2: rect.getPoint(x: 0.5, y: 0.8))
        path.addCurve(to: rect.getPoint(x: 0.05, y: 0.85), controlPoint1: rect.getPoint(x: 0.2, y: 0.8), controlPoint2: rect.getPoint(x: 0.1, y: 1.1))
        path.addCurve(to: rect.getPoint(x: 0.2, y: 0.05), controlPoint1: rect.getPoint(x: -0.05, y: 0.4), controlPoint2: rect.getPoint(x: 0.1, y: 0.1))
        path.close()
        path.addClip()
        
        if super.isStriped {
            super.drawStripes(bounds: rect, with: super.lineColor)
        } else if super.isSolid {
            super.lineColor.setFill()
            path.fill()
        }
        
        super.lineColor.setStroke()
        path.lineWidth = SetSymbolView.Ratio.lineWidthToSize * rect.maxX
        path.lineJoinStyle = .round
        path.stroke()
    }
}
