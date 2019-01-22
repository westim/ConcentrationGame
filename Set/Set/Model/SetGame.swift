//
//  SetGame.swift
//  Set
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

struct SetGame {
    
    var deck = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var dealtCards = [Card]()
    private(set) var playerScore = 0
    private(set) var aiScore = 0
    private let maxTimeBonus = 5
    private var lastPlay = Date.init()
    
    /// End game state is when there are no dealt cards & the deck is empty.
    var gameOver: Bool {
        return dealtCards.isEmpty && deck.isEmpty
    }
    
    /// Determines if the current selected set is a match.
    /// If current selection isn't a complete set, return `nil`.
    var selectedSetMatches: Bool? {
        return try? Card.makesSet(selectedCards)
    }
    
    init() {
        startGame()
    }
    
    /**
     Populates the deck with all possible card variations, shuffled randomly.
     
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
    
    // MARK: Bonus 3 (algorithm to find matching set)
    
    /**
     Searches the board for a set and returns the
     first found matching set.
     
     - Returns: Matching set of 3 cards or nil if no matching set is present
     */
    func findMatchingSet() -> [Card]? {
        if dealtCards.count < 3 {
            return nil
        }
        for card1 in dealtCards {
            for card2 in dealtCards {
                for card3 in dealtCards {
                    if (card1 != card2 && card2 != card3 && card1 != card3) {
                        if let matches = try? Card.makesSet([card1, card2, card3]), matches {
                            return [card1, card2, card3]
                        }
                    }
                }
            }
        }
        return nil
    }
    
    /**
     Deals the first 12 cards from the deck & resets the score.
     */
    mutating func startGame() {
        deck = createDeck()
        dealtCards = Array(deck[0..<12])
        deck.removeSubArray(subarray: dealtCards)
        playerScore = 0
        aiScore = 0
        lastPlay = Date.init()
    }
    
    /**
     Deals 3 cards from the deck. If the selected set
     matches, replace the selected set. Otherwise, add the
     cards to the collection of dealt cards.
     */
    mutating func dealCards(player: Player = .human) {
        let numberOfCardsToDeal = deck.count < 3 ? deck.count : 3
        let dealCards = Array(deck[0..<numberOfCardsToDeal])
        
        if let isMatch = selectedSetMatches, isMatch {  // Replace selected, matching cards
            replaceSelectedCards(using: dealCards)
        } else {  // Add cards to the game
            
            // MARK: Bonus 2 (penalty with available set)
            if findMatchingSet() != nil && player == .human {
                playerScore -= 3
            }
            dealtCards.append(contentsOf: dealCards)
        }
        deck.removeSubArray(subarray: dealCards)
    }
    
    /**
     Replaces the selected cards with new cards from the deck.
     If there are not enough cards from the deck, simply remove
     the dealt card from the game.
     */
    mutating private func replaceSelectedCards(using newCards: [Card]) {
        for selectedCardIndex in selectedCards.indices {
            guard let dealtCardIndex = dealtCards.index(of: selectedCards[selectedCardIndex]) else { return }
            if selectedCardIndex < newCards.count {
                dealtCards[dealtCardIndex] = newCards[selectedCardIndex]
            } else {
                dealtCards.remove(at: dealtCardIndex)
            }
        }
	selectedCards.removeAll()
    }
    
    /**
     Acts on the clicked `Card` according to the game rules.
     
     - Parameter clickedCard: The card that was selected by the player.
     */
    mutating func selectCard(clickedCardIndex: Int) {
        if let index = selectedCards.index(of: dealtCards[clickedCardIndex]), selectedCards.count != 3 {  // Deselect clicked card
            playerScore -= 1
            selectedCards.remove(at: index)
        } else {
             if let isMatched = selectedSetMatches, !isMatched {  // Deselect unmatched set & select clicked card
                playerScore -= 5 + timeBonus(maxBonus: maxTimeBonus)
                selectedCards.removeAll()
                selectedCards.append(dealtCards[clickedCardIndex])
            } else if let isMatched = selectedSetMatches, isMatched {  // Replace matched set
                playerScore += 3 + timeBonus(maxBonus: maxTimeBonus)
                dealCards()
            } else {  // Select clicked card
                selectedCards.append(dealtCards[clickedCardIndex])
            }
        }
    }
    
    mutating func aiSelect() {
        guard let set = findMatchingSet() else { return }
        selectedCards.removeAll()
        selectedCards.append(contentsOf: set)
        dealCards(player: .ai)
        aiScore += 3
    }
    
    // MARK: Bonus 1 (speed bonus/penalty)
    
    /**
     Calculates the score bonus earned from quick play
     and resets the last play to the current date & time.
     
     Note that this value will also be used as a penalty for
     quick mismatched sets; this is implemented to discourage quick
     but inaccurate guessing.
     
     - Parameter maxBonus: The maximum score bonus that can be earned, in seconds.
     
     - Returns: The score bonus.
     */
    private mutating func timeBonus(maxBonus: Int) -> Int {
        let timeSinceLastPlay = abs(lastPlay.timeIntervalSinceNow.rounded())
        let appliedBonus = maxBonus - Int(timeSinceLastPlay)
        lastPlay = Date.init()
        return appliedBonus > 0 ? appliedBonus : 0
    }
    
    enum AiState {
        case neutral, running, win, lose
    }
    
    enum Player {
        case human, ai
    }
}

