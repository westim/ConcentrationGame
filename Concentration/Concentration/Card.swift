//
//  Card.swift
//  Concentration
//
//  Created by Timothy West on 5/23/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation
import UIKit

struct Card {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    var hasBeenFlipped = false

    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
}

extension Card: Hashable {
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
