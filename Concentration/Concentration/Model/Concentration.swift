//
//  Concentration.swift
//  Concentration
//
//  Created by Timothy West on 5/23/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    private(set) var score = 0
    
    /// Holds the time of the last play.
    private var lastPlay = Date.init(timeIntervalSinceNow: 10)
    
    // MARK: Bonus 2
    /// Bonus for playing quickly.
    private var timeBonus: Int {
        mutating get {
            let value = lastPlay.timeIntervalSinceNow <= 0 ? 0 : lastPlay.timeIntervalSinceNow
            lastPlay = Date.init(timeIntervalSinceNow: 10)
            return Int(value)
        }
    }

    private var indexOfOneAndOnlyOneFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set(index) {
            allCardsFaceDown(exceptForIndex: index!)
        }
    }
    
    mutating private func allCardsFaceDown(exceptForIndex: Int) {
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = flipDownIndex == exceptForIndex
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards)): must have at least 1 pair of cards")
        startGame(numberOfPairsOfCards: numberOfPairsOfCards)
    }
 
    mutating func startGame(numberOfPairsOfCards: Int) {
        score = 0
        cards.removeAll()
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): index out of range")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2 + timeBonus
                } else if cards[index].hasBeenFlipped {
                    score -= 1
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyOneFaceUpCard = index
            }
        }
        cards[index].hasBeenFlipped = true
    }
    
    func isGameDone() -> Bool {
        return !cards.contains(where: { !$0.isMatched })
    }
}




