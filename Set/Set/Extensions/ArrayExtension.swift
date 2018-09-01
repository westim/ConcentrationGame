//
//  ArrayExtension.swift
//  Set
//
//  Created by Timothy West on 8/29/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

extension Array where Element == Bool {
    /**
     Randomly sets half of an `Array` of booleans to `true`.
     This method is inefficient because it can take any number
     of attempts to find an `Element` with value `false`.
     */
    mutating func setRandomHalfTrue() {
        while (self.filter { $0 }).count < self.count / 2 {
            self[Int(arc4random_uniform(UInt32(self.count)))] = true
        }
    }
}

// For Swift 4.2, we can use the `Sequence.shuffle()` method instead.
#if swift(>=4.2)
#else
extension Array {
    /**
     Implementation of Fischer-Yates shuffle.
     */
    mutating func shuffle() {
        if self.count >= 2 {
            for index in 0..<self.count - 1 {
                let swapIndex = Int(arc4random_uniform(UInt32(index + 1)))
                self.swapAt(index, swapIndex)
            }
        }
    }
}
#endif
