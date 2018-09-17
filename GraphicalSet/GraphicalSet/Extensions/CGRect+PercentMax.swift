//
//  CGRect+PercentMax.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/16/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    func percentMaxX(_ percent: CGFloat) -> CGFloat {
        return self.maxX * percent
    }
    
    func percentMaxY(_ percent: CGFloat) -> CGFloat {
        return self.maxY * percent
    }
}
