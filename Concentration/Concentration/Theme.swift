//
//  Theme.swift
//  Concentration
//
//  Created by Timothy West on 5/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    let Emojis: [String]
    let backgroundColor: UIColor
    let cardColor: UIColor
    
    init(emojis: [String], bgColor: UIColor, fgColor: UIColor) {
        Emojis = emojis
        backgroundColor = bgColor
        cardColor = fgColor
    }
}
