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
    
    private let secondsPerTurn: Double = 3
    private var turnTimer: Timer? = nil {
        willSet {
            turnTimer?.invalidate()
        }
    }
    
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
    
    private var updateCardsOnNextTouch: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        game.startGame()
        updateViewFromModel()
        setupDynamicFonts()
    }
    
    private func setupDynamicFonts() {
        guard let customFont = UIFont(name: "SFProText-Semibold", size: 24) else {
            fatalError("""
        Failed to load the "SF-Pro-Text-Semibold" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        
        let scaledFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        player1ScoreLabel.font = scaledFont
        player2ScoreLabel.font = scaledFont
        player1Label.font = scaledFont
        player2Label.font = scaledFont
        player1Deal3CardsButton?.titleLabel?.font = scaledFont
        player2Deal3CardsButton?.titleLabel?.font = scaledFont
        player1ClaimSetButton?.titleLabel?.font = scaledFont
        player2ClaimSetButton?.titleLabel?.font = scaledFont
    }
    
    private func startTurn() {
        if game.currentTurn == .none {
            turnTimer = nil
        } else {
            turnTimer = Timer.scheduledTimer(timeInterval: secondsPerTurn, target: self, selector: #selector(expireTurn), userInfo: nil, repeats: false)
        }
    }
    
    @objc private func expireTurn() {
        game.expireTurn()
        endTurn()
        updateViewFromModel()
    }
    
    private func endTurn() {
        player1ClaimSetButton.removeHighlight()
        player2ClaimSetButton.removeHighlight()
    }

    @objc private func touchCard(_ sender: CardView) {
        if game.currentTurn == .none { return }
        guard let index = CardAreaView.cards.index(of: sender) else { return }
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
    
    @IBOutlet private var player1Label: UILabel!
    @IBOutlet private var player2Label: UILabel!
    @IBOutlet private var player2ScoreLabel: UILabel!
    @IBOutlet private var player1ScoreLabel: UILabel!
    @IBOutlet private var CardAreaView: CardAreaView!
    @IBOutlet private var player1Deal3CardsButton: UIButton!
    @IBOutlet private var player2Deal3CardsButton: UIButton!
    @IBOutlet private var player1ClaimSetButton: ClaimTurnButton!
    @IBOutlet private var player2ClaimSetButton: ClaimTurnButton!
    
    @IBAction func deal3Cards(_ sender: UIButton?) {
        if game.currentTurn == .none { return }
        game.dealCards()
        updateViewFromModel()
        expireTurn()
    }
    
    @IBAction func touchClaimSetButton(_ sender: UIButton) {
        if game.currentTurn == .none {
            if sender == player1ClaimSetButton {
                game.currentTurn = .player1
                player1ClaimSetButton.highlightBorder()
            } else {
                game.currentTurn = .player2
                player2ClaimSetButton.highlightBorder()
            }
            startTurn()
        }
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
            let symbol = symbols[card.Attribute1] ?? SquiggleView.self
            let count = counts[card.Attribute2] ?? 0
            let color = colors[card.Attribute3] ?? UIColor.white
            let fill = fills[card.Attribute4] ?? SetSymbolView.FillType.none
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
        CardAreaView.removeAllCards()
        
        let cardViews = createCardViews(from: game.dealtCards)
        CardAreaView.add(cardViews)
    }
    
    private func updateScoreLabel() {
        player1ScoreLabel.text = "Score: \(game.player1Score)"
        player2ScoreLabel.text = "Score: \(game.player2Score)"
    }
    
    private func updateViewFromModel() {
        
        updateScoreLabel()
        
        if game.dealtCards.count != CardAreaView.cards.count || updateCardsOnNextTouch {
            updateCards()
            updateCardsOnNextTouch = false
        }

        for index in game.dealtCards.indices {
            if game.selectedCards.contains(game.dealtCards[index]) {
                CardAreaView.cards[index].isSelected = true
                
                // Add colors to indicate a successful/unsuccessful set
                if let isSetMatching = game.selectedSetMatches {
                    CardAreaView.cards[index].isMatching = isSetMatching
                    updateCardsOnNextTouch = true
                } else {
                    CardAreaView.cards[index].isMatching = nil
                }
            } else {
                // Clear border color for unselected cards
                CardAreaView.cards[index].isSelected = false
            }
        }
        
        if game.currentTurn == .none {
            endTurn()
        }
    }
}
