//
//  CGRect+points.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/16/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    /**
     Gets a point as a percentage of `maxX` and `maxY`.
     
     - Parameter x: Percent of `maxX`.
     - Parameter y: Percent of `maxY`.
     
     - Return: Point in the rect.
     */
    func getPoint(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.maxX * x, y: self.maxY * y)
    }
    
    /**
     Center of the current `CGRect`.
     
     This is useful for getting the center of `UIView.bounds`
     rather than the center of `UIView.frame`.
     */
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}
