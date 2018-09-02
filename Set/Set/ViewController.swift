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
        [.one: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1),
         .two: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1),
         .three: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
    private let counts: [Card.Variant: Int] =
        [.one: 1,
         .two: 2,
         .three: 3]
    
    private var isBoardFull: Bool {
        return game.dealtCards.count == cardButtons.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var deal3CardsButton: UIButton!
    
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
    
    private func updateViewFromModel() {
        if game.gameOver {
            endGame()
        } else {
            // Can't deal cards when the board is full or deck is empty
            deal3CardsButton.isEnabled = !isBoardFull || !game.deck.isEmpty
        }

        for index in cardButtons.indices {
            let button = cardButtons[index]
            if game.dealtCards.indices.contains(index) {
                let card = game.dealtCards[index]
                button.isHidden = false
                
                // TODO: Move this logic for card selection graphic to another function
                if game.selectedCards.contains(card) {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
                } else {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                }
            } else {
                button.isHidden = true
            }
        }
    }
}
