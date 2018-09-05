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
    
    private let shapes: [Card.Variant: String] =
        [.one: "▲",
         .two: "■",
         .three: "●"]
    private let colors: [Card.Variant: UIColor] =
        [.one: UIColor(red: 1, green: 1, blue: 0, alpha: 1),
         .two: UIColor(red: 1, green: 0, blue: 1, alpha: 1),
         .three: UIColor(red: 0, green: 1, blue: 1, alpha: 1)]
    private let counts: [Card.Variant: Int] =
        [.one: 1,
         .two: 2,
         .three: 3]
    
    private var isBoardFull: Bool {
        return game.dealtCards.count == cardButtons.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for button in cardButtons {
            button.layer.cornerRadius = 8.0
            button.titleLabel?.font.withSize(12.0)
        }
        createDeal3CardsDisabledText()
        updateViewFromModel()
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        guard let index = cardButtons.index(of: sender) else { return }
        game.selectCard(clickedCardIndex: index)
        updateViewFromModel()
    }
    
    @IBAction func touchHint(_ sender: UIButton) {
        guard let set = game.findMatchingSet() else { return }
        for card in set {
            let index = game.dealtCards.index(of: card)
            let button = cardButtons[index!]
            button.layer.borderWidth = 3.0
            button.layer.borderColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    @IBOutlet weak var cardsLeftLabel: UILabel! {
        didSet {
            updateCardsLeftLabel()
        }
    }
    
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var deal3CardsButton: UIButton!
    @IBOutlet private weak var hintButton: UIButton!
    
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
    
    /**
     Constructs the card's attributed text based on
     the card's other attributes.
     
     - Parameter card: The card for which to create attributed text.
     
     - Returns: Attributed text for the card.
     */
    private func getAttributedText(forCard card: Card) -> NSAttributedString? {
       
        guard let shape = shapes[card.Attribute1] else { return nil }
        guard let color = colors[card.Attribute2] else { return nil }
        guard let count = counts[card.Attribute3] else { return nil }
        
        let cardText = String(repeating: shape, count: count)
        var attributes = [NSAttributedStringKey : Any]()
        
        switch card.Attribute4 {
            case .one: // outlined
                attributes[NSAttributedStringKey.strokeWidth] = 10
                fallthrough
            case .two: // solid
                attributes[NSAttributedStringKey.foregroundColor] = color
            case .three: // faded
                attributes[NSAttributedStringKey.foregroundColor] = color.withAlphaComponent(0.5)
        }
        
        let attributedText = NSAttributedString(string: cardText, attributes: attributes)
        return attributedText
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
        
        if game.gameOver {
            endGame()
        } else {
            // Can't deal cards when the board is full or deck is empty
            deal3CardsButton.isEnabled = !isBoardFull && !game.deck.isEmpty
        }

        for index in game.dealtCards.indices {
            enableButton(at: index)
            cardButtons[index].setAttributedTitle(getAttributedText(forCard: game.dealtCards[index]), for: .normal)
            
            if game.selectedCards.contains(game.dealtCards[index]) {
                addSelectedBorder(to: index)
                
                // Add colors to indicate a successful/unsuccessful set
                if let isSetMatching = game.selectedSetMatches {
                    cardButtons[index].layer.backgroundColor = isSetMatching ? UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor : UIColor(red: 1, green: 0, blue: 0, alpha: 0.3).withAlphaComponent(0.3).cgColor
                }
            } else {
                // Clear border color for unselected cards
                cardButtons[index].layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
            }
        }
        hideUnusedButtons()
    }
    
    private func enableButton(at index: Int) {
        let button = cardButtons[index]
        button.isEnabled = true
        button.swapToColor(withDuration: 0.2, toColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1))
    }
    
    private func hideUnusedButtons() {
        let hiddenButtons: [UIButton] = cardButtons.filter { !game.dealtCards.indices.contains(cardButtons.index(of: $0)!) }
        hiddenButtons.forEach() { $0.swapToColor(withDuration: 0.2, toColor: super.view.backgroundColor!); $0.isEnabled = false; $0.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0); $0.setAttributedTitle(nil, for: .normal) }
    }
    
    private func addSelectedBorder(to index: Int) {
        let button = cardButtons[index]
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1).cgColor
    }
}
