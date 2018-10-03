//
//  ViewController.swift
//  Set
//
//  Created by Timothy West on 8/26/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = SetGame()
    
    private var symbols = [
        Card.Variant.one: SquiggleView.self,
        Card.Variant.two: DiamondView.self,
        Card.Variant.three: OvalView.self
    ]
    private var counts = [
        Card.Variant.one: 1,
        Card.Variant.two: 2,
        Card.Variant.three: 3
    ]
    private var fills = [
        Card.Variant.one: SetSymbolView.FillType.none,
        Card.Variant.two: SetSymbolView.FillType.solid,
        Card.Variant.three: SetSymbolView.FillType.stripe
    ]
    private var colors = [
        Card.Variant.one: UIColor.cyan,
        Card.Variant.two: UIColor.magenta,
        Card.Variant.three: UIColor.yellow
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        game.startGame()
        createDeal3CardsDisabledText()
        updateViewFromModel()
    }
    
    @objc func touchCard(_ sender: CardView) {
        clearHint()
        
        guard let index = CardAreaView.cards.index(of: sender) else { return }
        game.selectCard(clickedCardIndex: index)
        updateViewFromModel()
    }
    
    @IBAction func touchHint(_ sender: UIButton) {
        guard let set = game.findMatchingSet() else { return }
        for card in set {
            let index = game.dealtCards.index(of: card)
            CardAreaView.cards[index!].isHinted = true
        }
    }
    
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var cardsLeftLabel: UILabel!
    @IBOutlet private var CardAreaView: CardAreaView!
    
    @IBOutlet private var newGameButton: UIButton!
    @IBOutlet private var deal3CardsButton: UIButton!
    @IBOutlet private var hintButton: UIButton!
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.startGame()
        newGameButton.isHidden = true
        deal3CardsButton.isHidden = false
        updateViewFromModel()
    }
    
    @IBAction func deal3Cards(_ sender: UIButton) {
        game.dealCards()
        updateViewFromModel()
    }

    private func endGame() {
        newGameButton.isHidden = false
        deal3CardsButton.isHidden = true
    }
    
    /**
     Create a `CardView` from a `Card`.
     
     - Parameter card: The `Card` to convert.
     
     - Returns: `CardView`.
     */
    private func createCardView(from card: Card) -> CardView {
        let cardView = CardView()
        cardView.symbol = symbols[card.Attribute1] ?? SquiggleView.self
        cardView.count = counts[card.Attribute2] ?? 0
        cardView.color = colors[card.Attribute3] ?? UIColor.white
        cardView.fill = fills[card.Attribute4] ?? SetSymbolView.FillType.none
        cardView.addTarget(self, action: #selector(touchCard(_:)), for: .touchUpInside)
        
        return cardView
    }
    
    private func noMatchingSet() {
        CardAreaView.cards.forEach { $0.isMatching = nil }
    }
    
    private func removeAllCardsFromPlay() {
        CardAreaView.cards.forEach { $0.removeFromSuperview() }
    }
    
    private func clearHint() {
        CardAreaView.cards.forEach { $0.isHinted = false }
    }
    
    /**
     Changes the Deal 3 Cards button text color to indicate
     that no more cards can be dealt.
     */
    private func createDeal3CardsDisabledText() {
        let disabledAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: UIColor.red
        ]
        deal3CardsButton.setAttributedTitle(NSAttributedString(string: deal3CardsButton.titleLabel!.text!, attributes: disabledAttributes), for: .disabled)
    }

    /**
     Updates the card views currently played.
     */
    private func updateCards() {
        removeAllCardsFromPlay()
        
        for gameCard in game.dealtCards {
            let cardView = createCardView(from: gameCard)
            CardAreaView.add(cardView)
        }
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func updateCardsLeftLabel() {
        cardsLeftLabel.text = "Cards Left: \(game.deck.count)"
    }
    
    private func updateViewFromModel() {
        
        updateScoreLabel()
        updateCardsLeftLabel()
        
        if game.dealtCards.count != CardAreaView.cards.count {
            updateCards()
        }
        
        if game.gameOver {
            endGame()
        } else {
            // Can't deal cards when the deck is empty
            deal3CardsButton.isEnabled = !game.deck.isEmpty
        }

        for index in game.dealtCards.indices {
            
            if game.selectedCards.contains(game.dealtCards[index]) {
                CardAreaView.cards[index].isSelected = true
                
                // Add colors to indicate a successful/unsuccessful set
                if let isSetMatching = game.selectedSetMatches {
                    CardAreaView.cards[index].isMatching = isSetMatching
                } else {
                    noMatchingSet()
                }
            } else {
                // Clear border color for unselected cards
                CardAreaView.cards[index].isSelected = false
            }
        }
    }
}
