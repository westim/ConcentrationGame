//
//  ViewController.swift
//  Set
//
//  Created by Timothy West on 8/26/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Set()
    
    private let shapes: [Card.Variant: String] =
        [.one: "▲",
         .two: "■",
         .three: "●"]
    private let colors: [Card.Variant: UIColor] =
        [.one: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1),
         .two: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1),
         .three: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]
    private let counts: [Card.Variant: Int] =
        [.one: 1,
         .two: 2,
         .three: 3]
    
    private var isBoardFull: Bool {
        return game.dealtCards.count == cardButtons.count
    }
    
    private var isDealCardButtonEnabled: Bool {
        return !isBoardFull && !game.deck.isEmpty
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
        let index = cardButtons.index(of: sender)
        game.selectCard(clickedCard: game.dealtCards[index!])
        updateViewFromModel()
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
    
    /**
     Changes the Deal 3 Cards button text color to indicate
     that no more cards can be dealt.
     */
    private func createDeal3CardsDisabledText() {
        let disabledAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: UIColor(cgColor: #colorLiteral(red: 0.748572335, green: 0.1119795426, blue: 0.006467502925, alpha: 1))
        ]
        deal3CardsButton.setAttributedTitle(NSAttributedString(string: deal3CardsButton.titleLabel!.text!, attributes: disabledAttributes), for: .disabled)
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.startGame()
        newGameButton.isEnabled = false
        newGameButton.isHidden = true
        deal3CardsButton.isEnabled = true
        deal3CardsButton.isHidden = false
        updateViewFromModel()
    }
    
    private func endGame() {
        newGameButton.isEnabled = true
        newGameButton.isHidden = false
        deal3CardsButton.isEnabled = false
        deal3CardsButton.isHidden = true
    }
    
    @IBAction func deal3Cards(_ sender: UIButton) {
        game.dealThreeCards()
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
            case .three: // striped
                attributes[NSAttributedStringKey.foregroundColor] = color.withAlphaComponent(0.3)
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
            deal3CardsButton.isEnabled = isDealCardButtonEnabled
        }

        for index in cardButtons.indices {
            let button = cardButtons[index]
            if game.dealtCards.indices.contains(index) {
                let card = game.dealtCards[index]
                button.swapToColor(withDuration: 0.2, toColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                button.isEnabled = true
                button.setAttributedTitle(getAttributedText(forCard: card), for: .normal)
                
                // TODO: Move this logic for card selection graphic to another function
                if game.selectedCards.contains(card) {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
                } else {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                }
            } else {
                button.swapToColor(withDuration: 0.2, toColor: super.view.backgroundColor!)
                button.isEnabled = false
                button.setAttributedTitle(nil, for: .normal)
            }
        }
    }
}
