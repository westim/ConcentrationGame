//
//  UIButtonExtension.swift
//  Concentration
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    /**
     Creates an animation which transitions to the given color
     over the given time interval.
     
     - Parameter withDuration: The time duration of the animation in seconds.
     
     - Parameter toColor: The color to transition to.
    */
    func swapToColor(withDuration: TimeInterval, toColor color: UIColor) {
        UIView.animate(withDuration: withDuration, animations: { () -> Void in
            self.backgroundColor = color;
        })
    }
}
