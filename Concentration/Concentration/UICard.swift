//
//  UICard.swift
//  Concentration
//
//  Created by Timothy West on 5/26/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

@IBDesignable
class UICard: UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
