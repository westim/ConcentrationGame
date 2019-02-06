//
//  Card.swift
//  Set
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

struct Card: Equatable {

    let Attribute1: Variant
    let Attribute2: Variant
    let Attribute3: Variant
    let Attribute4: Variant
    
    private var attributeArray: [Variant] {
        get {
            return [Attribute1, Attribute2, Attribute3, Attribute4]
        }
    }
    
    init(Att1: Variant, Att2: Variant, Att3: Variant, Att4: Variant) {
        Attribute1 = Att1
        Attribute2 = Att2
        Attribute3 = Att3
        Attribute4 = Att4
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.attributeArray.elementsEqual(rhs.attributeArray)
    }
    
    static func !=(lhs: Card, rhs: Card) -> Bool {
        return !lhs.attributeArray.elementsEqual(rhs.attributeArray)
    }
    
    /**
     Determines whether the three given `Card` form a set.
     
     In summary, the following criteria must be met:
     
     - At least two attributes are unique (different for every card in the set)
     - All non-unique attributes are the same for all cards in the set
     
     - Parameter cards: Array of cards to check
     
     - Returns: true if the cards form a set, else false.
     */
    static func makesSet(_ cards: [Card]) throws -> Bool {
        // TODO: Add proper error-handling here
        if cards.count != 3 {
            throw ArgumentError.invalidArraySize("Set has \(cards.count); can't check a set that doesn't have exactly 3 cards")
        }
        return getNumberOfUniqueAttributes(cards: cards) >= 1 &&
               (getNumberOfUniqueAttributes(cards: cards) +
               getNumberOfSharedAttributes(cards: cards) == 4)
    }
    
    // TODO: Make these attribute comparisons less ugly
    static private func getNumberOfUniqueAttributes(cards: [Card]) -> Int {
        var numOfUniqueAttributes = 0
        if cards[0].Attribute1 != cards[1].Attribute1 && cards[1].Attribute1 != cards[2].Attribute1 && cards[0].Attribute1 != cards[2].Attribute1 {
            numOfUniqueAttributes += 1
        }
        if cards[0].Attribute2 != cards[1].Attribute2 && cards[1].Attribute2 != cards[2].Attribute2 && cards[0].Attribute2 != cards[2].Attribute2 {
            numOfUniqueAttributes += 1
        }
        if cards[0].Attribute3 != cards[1].Attribute3 && cards[1].Attribute3 != cards[2].Attribute3 && cards[0].Attribute3 != cards[2].Attribute3 {
            numOfUniqueAttributes += 1
        }
        if cards[0].Attribute4 != cards[1].Attribute4 && cards[1].Attribute4 != cards[2].Attribute4 && cards[0].Attribute4 != cards[2].Attribute4 {
            numOfUniqueAttributes += 1
        }
        return numOfUniqueAttributes
    }
    
    static private func getNumberOfSharedAttributes(cards: [Card]) -> Int {
        var numOfSharedAttributes = 0
        if cards[0].Attribute1 == cards[1].Attribute1 && cards[1].Attribute1 == cards[2].Attribute1 {
            numOfSharedAttributes += 1
        }
        if cards[0].Attribute2 == cards[1].Attribute2 && cards[1].Attribute2 == cards[2].Attribute2 {
            numOfSharedAttributes += 1
        }
        if cards[0].Attribute3 == cards[1].Attribute3 && cards[1].Attribute3 == cards[2].Attribute3 {
            numOfSharedAttributes += 1
        }
        if cards[0].Attribute4 == cards[1].Attribute4 && cards[1].Attribute4 == cards[2].Attribute4 {
            numOfSharedAttributes += 1
        }
        return numOfSharedAttributes
    }
    
    // MARK: use CaseIterable Protocol in Swift 4.2
    enum Variant {
        case one
        case two
        case three
        
        static var all: [Variant]{ return [one, two, three] }
    }
}

enum ArgumentError: Error {
    case invalidArraySize(String)
}
