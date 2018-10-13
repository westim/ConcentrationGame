//
//  UIView+addSubViews.swift
//  GraphicalSet
//
//  Created by Timothy West on 10/4/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /**
     Adds a set of `UIView` as subviews to the
     current `UIView`.
     
     - Parameter views: The array of views to add.
     */
    func addSubViews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    /**
     Removes all `UIView` from `self.subviews`.
     */
    func removeAllSubViews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
