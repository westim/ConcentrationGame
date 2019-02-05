//
//  TriangleView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/16/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class OvalView: SetSymbolView {
    
    required init(frame: CGRect, fill: SetSymbolView.FillType, color: UIColor) {
        super.init(frame: frame, fill: fill, color: color)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2)
        path.addClip()
        
        if isStriped {
            drawStripes(bounds: rect, with: lineColor)
        } else if isSolid {
            lineColor.setFill()
            path.fill()
        }
        
        lineColor.setStroke()
        path.lineWidth = lineWidth
        
        path.stroke()
    }
}
