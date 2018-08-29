//
//  IntExtension.swift
//  Concentration
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

extension Int {
    /// Simplification of arc4random_uniform.
    var arc4random: Int {
        return self == 0 ? 0 : Int(arc4random_uniform(UInt32(abs(self))))
    }
}
