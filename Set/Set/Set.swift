//
//  Set.swift
//  Set
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

struct Set {
    
    private var deck: [Card]
    private(set) var selectedCards: [Card]
    private(set) var score = 0
    
    /// Determines if the current selected set is a match.
    /// If current selection isn't a complete set, return `nil`.
    private var selectedSetMatches: Bool? {
        if selectedCards.count != 3 {
            return nil
        } else {
            return Card.makesSet(selectedCards)
        }
    }
    
    /// Array of indices for dealt cards where true = dealt
    private(set) var dealtCards: [Card]
    
    /**
     Populates the deck with all possible card variations, shuffled.
     
     - Returns: Shuffled deck of `Card`
     */
    private func createDeck() -> [Card] {
        var newDeck = [Card]()
        for attribute1 in Card.Variant.all {
            for attribute2 in Card.Variant.all {
                for attribute3 in Card.Variant.all {
                    for attribute4 in Card.Variant.all {
                        newDeck.append(Card(Att1: attribute1, Att2: attribute2, Att3: attribute3, Att4: attribute4))
                    }
                }
            }
        }
        newDeck.shuffle()
        return newDeck
    }
    
    /**
     Deals the first 12 cards from the deck & resets the score.
     */
    mutating func startGame() {
        deck = createDeck()
        dealtCards = Array(deck[0..<12])
        deck.removeSubArray(subarray: dealtCards)
        score = 0
    }
    
    /**
     Deals 3 cards from the deck. If the selected set
     matches, replace the selected set. Otherwise, add the
     cards to the collection of dealt cards.
     */
    mutating private func dealThreeCards() {
        let dealCards = Array(deck[0..<3])
        
        if let isMatch = selectedSetMatches, isMatch {
            selectedCards = dealCards
        } else {
            dealtCards.append(contentsOf: dealCards)
        }
        
        deck.removeSubArray(subarray: dealCards)
    }
    
    /**
     Acts on the clicked `Card` according to the game rules.
     
     - Parameter clickedCard: The card that was selected by the player.
     */
    mutating func selectCard(clickedCard: Card) {
        if let index = selectedCards.index(of: clickedCard), selectedCards.count != 3 { // Deselect clicked card
            selectedCards.remove(at: index)
        } else {
             if let isMatched = selectedSetMatches, !isMatched {                        // Deselect unmatched set & select clicked card
                selectedCards.removeAll()
                selectedCards.append(clickedCard)
            } else if let isMatched = selectedSetMatches, isMatched {                   // Replace matched set
                score += 3
                dealThreeCards()
                if dealtCards.contains(clickedCard) {                                   // Don't try to select a card that was just removed
                    selectedCards.append(clickedCard)
                }
            } else {                                                                    // Select clicked card
                selectedCards.append(clickedCard)
            }
        }
    }
}

