//
//  ArrayExtension.swift
//  Set
//
//  Created by Timothy West on 8/29/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

// For Swift 4.2, we can use the `Sequence.shuffle()` method instead
extension Array where Element: Equatable {
#if !swift(>=4.2)
    /**
     Implementation of Fischer-Yates shuffle.
     */
    mutating func shuffle() {
        if self.count >= 2 {
            for index in 0..<self.count {
                let swapIndex = Int(arc4random_uniform(UInt32(index + 1)))
                self.swapAt(index, swapIndex)
            }
        }
    }
#endif
    /**
     Removes all elements of the subarray from the array.
     
     - Parameter: subarray the subarray to remove
     */
    mutating func removeSubArray(subarray: [Element]) {
        self = self.filter { !subarray.contains($0) }
    }
}
