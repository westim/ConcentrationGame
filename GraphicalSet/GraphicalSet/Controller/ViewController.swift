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
        Card.Variant.one: UIColor(red: 1, green: 0, blue: 1, alpha: 1),
        Card.Variant.two: UIColor(red: 0, green: 1, blue: 1, alpha: 1),
        Card.Variant.three: UIColor(red: 1, green: 1, blue: 0, alpha: 1)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        createDeal3CardsDisabledText()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: CardView) {
        guard let index = CardAreaView.cards.index(of: sender) else { return }
        game.selectCard(clickedCardIndex: index)
        updateViewFromModel()
    }
    
    @IBAction func touchHint(_ sender: UIButton) {
        guard let set = game.findMatchingSet() else { return }
        for card in set {
            let index = game.dealtCards.index(of: card)
            let button = CardAreaView.cards[index!]
            button.layer.borderWidth = 3.0
            button.layer.borderColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var cardsLeftLabel: UILabel!

    @IBOutlet var CardAreaView: CardAreaView!
    @IBOutlet private var newGameButton: UIButton!
    @IBOutlet private var deal3CardsButton: UIButton!
    @IBOutlet private var hintButton: UIButton!
    
    /**
     Updates the card views currently played.
     */
    private func updateCards() {
        for gameCard in game.dealtCards {
            let cardView = createCardView(from: gameCard)
            CardAreaView.add(cardView)
        }
    }
    
    private func createCardView(from card: Card) -> CardView {
        let cardView = CardView()
        cardView.symbol = symbols[card.Attribute1] ?? SquiggleView.self
        cardView.count = counts[card.Attribute2] ?? 0
        cardView.color = colors[card.Attribute3] ?? UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        cardView.fill = fills[card.Attribute4] ?? SetSymbolView.FillType.none
        cardView.addTarget(self, action: #selector(touchCard), for: .touchUpInside)
        
        return cardView
    }
    
    /**
     Changes the Deal 3 Cards button text color to indicate
     that no more cards can be dealt.
     */
    private func createDeal3CardsDisabledText() {
        let disabledAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        ]
        deal3CardsButton.setAttributedTitle(NSAttributedString(string: deal3CardsButton.titleLabel!.text!, attributes: disabledAttributes), for: .disabled)
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.startGame()
        newGameButton.isHidden = true
        deal3CardsButton.isHidden = false
        deal3CardsButton.isEnabled = true
        updateViewFromModel()
    }
    
    private func endGame() {
        newGameButton.isHidden = false
        deal3CardsButton.isHidden = true
    }
    
    @IBAction func deal3Cards(_ sender: UIButton) {
        game.dealCards()
        updateViewFromModel()
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func updateCardsLeftLabel() {
        cardsLeftLabel.text = "Cards Left: \(game.deck.count)"
    }
    
    private func updateViewFromModel() {
        updateCards()
        updateScoreLabel()
        updateCardsLeftLabel()
        
        if game.gameOver {
            endGame()
        } else {
            // Can't deal cards when the deck is empty
            deal3CardsButton.isEnabled = !game.deck.isEmpty
        }

        for index in game.dealtCards.indices {
            
            if game.selectedCards.contains(game.dealtCards[index]) {
                addSelectedBorder(to: index)
                
                // Add colors to indicate a successful/unsuccessful set
                if let isSetMatching = game.selectedSetMatches {
                    if isSetMatching {
                        CardAreaView.cards[index].layer.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor
                    } else {
                        CardAreaView.cards[index].layer.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.3).cgColor
                    }
                }
            } else {
                // Clear border color for unselected cards
                CardAreaView.cards[index].layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            }
        }
    }
    
    /**
     Creates a highlighted border around the specified button.
     
     - Parameter index: The index of the button to highlight.
     */
    private func addSelectedBorder(to index: Int) {
        let button = CardAreaView.cards[index]
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1).cgColor
    }
}
