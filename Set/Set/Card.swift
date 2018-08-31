//
//  Card.swift
//  Set
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

struct Card {
    let Attribute1: Variant
    let Attribute2: Variant
    let Attribute3: Variant
    let Attribute4: Variant
    
    init(Att1: Variant, Att2: Variant, Att3: Variant, Att4: Variant) {
        Attribute1 = Att1
        Attribute2 = Att2
        Attribute3 = Att3
        Attribute4 = Att4
    }
    
    /**
     Determines whether the three given `Card` form a set.
     
     - Parameter card0: First card.
     - Parameter card1: Second card.
     - Parameter card2: Third card.
     
     - Returns: true if the cards form a set, else false.
     */
    static func makesSet(of card0: Card, with card1: Card, and card2: Card) -> Bool {
        return getNumberOfUniqueAttributes(card0: card0, card1: card1, card2: card2) +
               getNumberOfSharedAttributes(card0: card0, card1: card1, card2: card2) == 4
    }
    
    static private func getNumberOfUniqueAttributes(card0: Card, card1: Card, card2: Card) -> Int {
        var numOfUniqueAttributes = 0
        if card0.Attribute1 != card1.Attribute1 && card1.Attribute1 != card2.Attribute1 && card0.Attribute1 != card2.Attribute1 {
            numOfUniqueAttributes += 1
        }
        if card0.Attribute2 != card1.Attribute2 && card1.Attribute2 != card2.Attribute2 && card0.Attribute2 != card2.Attribute2 {
            numOfUniqueAttributes += 1
        }
        if card0.Attribute3 != card1.Attribute3 && card1.Attribute3 != card2.Attribute3 && card0.Attribute3 != card2.Attribute3 {
            numOfUniqueAttributes += 1
        }
        if card0.Attribute4 != card1.Attribute4 && card1.Attribute4 != card2.Attribute4 && card0.Attribute4 != card2.Attribute4 {
            numOfUniqueAttributes += 1
        }
        return numOfUniqueAttributes
    }
    
    static private func getNumberOfSharedAttributes(card0: Card, card1: Card, card2: Card) -> Int {
        var numOfSharedAttributes = 0
        if card0.Attribute1 == card1.Attribute1 && card1.Attribute1 == card2.Attribute1 {
            numOfSharedAttributes += 1
        }
        if card0.Attribute2 == card1.Attribute2 && card1.Attribute2 == card2.Attribute2 {
            numOfSharedAttributes += 1
        }
        if card0.Attribute3 == card1.Attribute3 && card1.Attribute3 == card2.Attribute3 {
            numOfSharedAttributes += 1
        }
        if card0.Attribute4 == card1.Attribute4 && card1.Attribute4 == card2.Attribute4 {
            numOfSharedAttributes += 1
        }
        return numOfSharedAttributes
    }
    
    // TODO: use CaseIterable Protocol in Swift 4.2
    enum Variant: Int {
        case one = 1
        case two
        case three
        
        /// Returns an array with all possible cases
        static var all: [Variant]{ return [.one, .two, three] }
    }
}
