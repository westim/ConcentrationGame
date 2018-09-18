//
//  SquiggleView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/16/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class SquiggleView: SetSymbolView {

    override init(frame: CGRect, fill: SetSymbolView.FillType, color: UIColor) {
        super.init(frame: frame, fill: fill, color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.percentMaxX(0.1), y: rect.percentMaxY(0.05)))
        path.addCurve(to: CGPoint(x: rect.percentMaxX(0.9), y: rect.percentMaxY(0.05)), controlPoint1: CGPoint(x: rect.percentMaxX(0.3), y: rect.percentMaxY(0)), controlPoint2: CGPoint(x: rect.percentMaxX(0.7), y: rect.percentMaxY(0.7)))
        path.addQuadCurve(to: CGPoint(x: rect.percentMaxX(0.9), y: rect.percentMaxY(0.95)), controlPoint: CGPoint(x: rect.percentMaxX(1.1), y: rect.percentMaxY(0.5)))
        path.addCurve(to: CGPoint(x: rect.percentMaxX(0.1), y: rect.percentMaxY(0.95)), controlPoint1: CGPoint(x: rect.percentMaxX(0.7), y: rect.maxY), controlPoint2: CGPoint(x: rect.percentMaxX(0.3), y: rect.percentMaxY(0.3)))
        path.addQuadCurve(to: CGPoint(x: rect.percentMaxX(0.1), y: rect.percentMaxY(0.05)), controlPoint: CGPoint(x: rect.percentMaxX(-0.1), y: rect.percentMaxY(0.5)))
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
