//
//  ArrayExtension.swift
//  Concentration
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

extension Array {
    /** Implementation of Fischer-Yates shuffle. */
    mutating func shuffle() {
        if self.count >= 2 {
            for index in 0..<self.count - 1 {
                let swapIndex = Int(arc4random_uniform(UInt32(index + 1)))
                self.swapAt(index, swapIndex)
            }
        }
    }
}
