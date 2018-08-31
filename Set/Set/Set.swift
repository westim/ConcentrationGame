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
     Populates the deck with all possible card variations, shuffled.
     */
    mutating private func createDeck() {
        for attribute1 in Card.Variant.all {
            for attribute2 in Card.Variant.all {
                for attribute3 in Card.Variant.all {
                    for attribute4 in Card.Variant.all {
                        deck.append(Card(Att1: attribute1, Att2: attribute2, Att3: attribute3, Att4: attribute4))
                    }
                }
            }
        }
        deck.shuffle()
    }
    
    /**
     Starts the game by randomly dealing cards.
     */
    mutating func startGame(int numberOfCards: Int) {
        dealtCards = [Bool](repeating: false, count: numberOfCards)
        score = 0
        createDeck()
        
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
    

}

