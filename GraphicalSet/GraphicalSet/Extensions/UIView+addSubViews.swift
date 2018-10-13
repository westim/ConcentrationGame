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
    func addSubViews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    func removeAllSubViews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
