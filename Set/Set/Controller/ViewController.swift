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
    private var timer = Timer()
    
    private let shapes: [Card.Variant: String] =
        [.one: "▲",
         .two: "■",
         .three: "●"]
    private let colors: [Card.Variant: UIColor] =
        [.one: UIColor.magenta,
         .two: UIColor.yellow,
         .three: UIColor.purple]
    private let counts: [Card.Variant: Int] =
        [.one: 1,
         .two: 2,
         .three: 3]
    private let aiStates: [SetGame.AiState: String] =
        [.running: "🤔",
         .neutral: "😀",
         .win: "😂",
         .lose: "😭"]
    
    private var isBoardFull: Bool {
        return game.dealtCards.count == cardButtons.count
    }
    
    private var randomTimeInterval: TimeInterval {
        return Double.random(in: 5.0...10.0)
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
            button.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var cardsLeftLabel: UILabel!
    
    @IBOutlet private var newGameButton: UIButton!
    @IBOutlet private var deal3CardsButton: UIButton!
    @IBOutlet private var hintButton: UIButton!
    @IBOutlet private var AIButton: UIButton!
    
    @IBAction func clickAiButton(_ sender: UIButton) {
        fireNewTimer()
    }
    
    // MARK: Bonus 4 (AI Player)
    
    /**
     Recursively fires new timers at the random interval.
     */
    private func fireNewTimer() {
        updateAiButton(state: .running)
        timer.invalidate()
        let interval = randomTimeInterval
        
        // "Found match" timer
        Timer.scheduledTimer(withTimeInterval: interval - 2, repeats: false) { _ in self.updateAiButton(state: .neutral) }
        
        // Recursive timer
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) {_ in
            self.game.aiSelect()
            self.updateViewFromModel()
            self.fireNewTimer()
        }
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
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.startGame()
        newGameButton.isHidden = true
        deal3CardsButton.isHidden = false
        deal3CardsButton.isEnabled = true
        updateAiButton(state: .neutral)
        updateViewFromModel()
    }
    
    private func endGame() {
        let aiState: SetGame.AiState = game.playerScore > game.aiScore ? .lose : .win
        updateAiButton(state: aiState)
        timer.invalidate()
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
            case .one:  // outlined
                attributes[NSAttributedStringKey.strokeWidth] = 10
                fallthrough
            case .two:  // solid
                attributes[NSAttributedStringKey.foregroundColor] = color
            case .three:  // faded
                attributes[NSAttributedStringKey.foregroundColor] = color.withAlphaComponent(0.5)
        }
        
        let attributedText = NSAttributedString(string: cardText, attributes: attributes)
        return attributedText
    }
    
    private func updateAiButton(state: SetGame.AiState) {
        AIButton.setTitle(aiStates[state], for: .normal)
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "\(game.playerScore) : \(game.aiScore)"
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
                    if isSetMatching {
                        cardButtons[index].layer.backgroundColor = UIColor.green.withAlphaComponent(0.3).cgColor
                    } else {
                        cardButtons[index].layer.backgroundColor = UIColor.red.withAlphaComponent(0.3).cgColor
                    }
                }
            } else {
                // Clear border color for unselected cards
                cardButtons[index].layer.borderColor = UIColor.clear.cgColor
            }
        }
        hideUnusedButtons()
    }
    
    /**
     Enables the button at the given index.
     
     - Parameter index: The index of the button to enable.
     */
    private func enableButton(at index: Int) {
        cardButtons[index].isEnabled = true
        cardButtons[index].swapToColor(withDuration: 0.2, toColor: UIColor.black)
    }
    
    /**
     Identifies all unused buttons on the View and
     makes the buttons disabled and "invisible".
     */
    private func hideUnusedButtons() {
        let hiddenButtons: [UIButton] = cardButtons.filter { !game.dealtCards.indices.contains(cardButtons.index(of: $0)!) }
        hiddenButtons.forEach() {
            $0.swapToColor(withDuration: 0.2, toColor: super.view.backgroundColor!)
            $0.isEnabled = false
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.setAttributedTitle(nil, for: .normal) }
    }
    
    /**
     Creates a highlighted border around the specified button.
     
     - Parameter index: The index of the button to highlight.
     */
    private func addSelectedBorder(to index: Int) {
        let button = cardButtons[index]
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.yellow.cgColor
    }
}
