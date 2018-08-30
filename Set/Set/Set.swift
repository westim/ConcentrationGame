//
//  Set.swift
//  Set
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

struct Set {
    
    /// `Array` of indices for selected cards
    private(set) var selectedCards: [Int]
    private(set) var score = 0
    private var deck: [Card]
    
    /// Array of indices for dealt cards where true = dealt
    private(set) var dealtCards: [Bool]
    
    /**
     Starts the game by randomly dealing cards.
     */
    mutating func startGame(int numberOfCards: Int) {
        dealtCards = [Bool](repeating: false, count: numberOfCards)
        score = 0
        
        dealtCards.setRandomHalfTrue()
    }
    
    /**
     Deals 3 cards based on the first 3 undealt cards found.
     */
    mutating private func dealThreeCards() {
        var dealCount = 0
        for index in 0..<dealtCards.count {
            if dealCount < 3 && !dealtCards[index] {
                dealtCards[index] = true
                dealCount += 1
            }
        }
    }
    
    mutating func selectCard(selectedCardIndex: Int) {
        if let indexInSelectedCardsArray = selectedCards.index(of: selectedCardIndex) {
            selectedCards.remove(at: indexInSelectedCardsArray)
        }
        
        if selectedCards.count >= 3 {
            selectedCards.removeAll(keepingCapacity: false)
        }
        
        selectedCards.append(selectedCardIndex)
    }
    
    /**
     Determines whether the three given `Card` form a set.
     
     - Parameter card0: First card.
     - Parameter card1: Second card.
     - Parameter card2: Third card.
     
     - Returns: true if the cards form a set, else false.
     */
    func makesSet(of card0: Card, with card1: Card, and card2: Card) -> Bool {
        return getNumberOfUniqueAttributes(card0: card0, card1: card1, card2: card2) >= 2
    }
    
    private func getNumberOfUniqueAttributes(card0: Card, card1: Card, card2: Card) -> Int {
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
}

