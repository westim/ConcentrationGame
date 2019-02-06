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
    
    private var updateCardsOnNextTouch: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        game.startGame()
        updateViewFromModel()
        setupDynamicFonts()
    }
    
    private func setupDynamicFonts() {
        guard let customFont = UIFont(name: "SFProText-Semibold", size: 24) else {
            fatalError(
            """
            Failed to load the "SF-Pro-Text-Semibold" font.
            Make sure the font file is included in the project and the font name is spelled correctly.
            """
            )
        }
        
        let scaledFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        scoreLabel.font = scaledFont
        deal3CardsButton?.titleLabel?.font = scaledFont
        claimSetButton?.titleLabel?.font = scaledFont
    }

    @objc private func touchCard(_ sender: CardView) {
        guard let index = cardAreaView.cards.index(of: sender) else { return }
        game.selectCard(clickedCardIndex: index)
        updateViewFromModel()
    }
    
    @IBOutlet private var baseView: UIView! {
        didSet {
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipe(recognizer:)))
            swipeGestureRecognizer.direction = .down
            
            let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotate(recognizer:)))
            
            baseView.addGestureRecognizer(swipeGestureRecognizer)
            baseView.addGestureRecognizer(rotationGestureRecognizer)
        }
    }
    
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var cardAreaView: CardAreaView!
    @IBOutlet private var deal3CardsButton: UIButton!
    @IBOutlet private var claimSetButton: ClaimTurnButton!
    
    @IBAction private func deal3Cards(_ sender: UIButton?) {
        game.dealCards()
        updateViewFromModel()
    }
    
    @IBAction private func touchClaimSetButton(_ sender: UIButton) {
        claimSetButton.highlightBorder()
    }
    
    private func ShuffleCards() {
        game.shufflePlayedCards()
        updateCards()
        updateViewFromModel()
    }
    
    /**
     Create a `CardView` from a `Card`.
     
     - Parameter card: The `Card` to convert.
     
     - Returns: `CardView`.
     */
    private func createCardViews(from cards: [Card]) -> [CardView] {
        var cardViews = [CardView]()
        for card in cards {
            let symbol = Map.symbols[card.Attribute1] ?? SquiggleView.self
            let count = Map.counts[card.Attribute2] ?? 0
            let color = Map.colors[card.Attribute3] ?? UIColor.white
            let fill = Map.fills[card.Attribute4] ?? SetSymbolView.FillType.none
            let cardView = CardView(count: count, color: color, fill: fill, symbol: symbol)
            cardView.addTarget(self, action: #selector(touchCard(_:)), for: .touchUpInside)
            cardViews.append(cardView)
        }

        return cardViews
    }

    @objc private func swipe(recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            deal3Cards(nil)
        }
    }
    
    @objc private func rotate(recognizer: UIRotationGestureRecognizer) {
        if recognizer.state == .ended {
            ShuffleCards()
        }
    }
    
    /**
     Updates the card views currently played.
     */
    private func updateCards() {
        cardAreaView.removeAllCards()
        
        let cardViews = createCardViews(from: game.dealtCards)
        cardAreaView.add(cardViews)
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func updateViewFromModel() {
        
        updateScoreLabel()
        
        if game.dealtCards.count != cardAreaView.cards.count || updateCardsOnNextTouch {
            updateCards()
            updateCardsOnNextTouch = false
        }

        for index in game.dealtCards.indices {
            if game.selectedCards.contains(game.dealtCards[index]) {
                cardAreaView.cards[index].isSelected = true
                
                // Add colors to indicate a successful/unsuccessful set
                if let isSetMatching = game.selectedSetMatches {
                    cardAreaView.cards[index].isMatching = isSetMatching
                    updateCardsOnNextTouch = true
                } else {
                    cardAreaView.cards[index].isMatching = nil
                }
            } else {
                // Clear border color for unselected cards
                cardAreaView.cards[index].isSelected = false
            }
        }
        claimSetButton.removeHighlight()
    }
}
