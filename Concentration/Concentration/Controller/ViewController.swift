//
//  ViewController.swift
//  Concentration
//
//  Created by Timothy West on 5/22/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // Change this line of code to change theme!
    private lazy var currentTheme = halloween
    
    private lazy var emojiChoices = currentTheme.Emojis
    private let halloween = Theme(emojis: ["🎃", "👻", "🦇", "🙀", "🍭", "🍫", "😱", "😈"], bgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), fgColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1))
    private let christmas = Theme(emojis: ["❄️", "⛄️", "🎅🏻", "😇", "👼🏻", "🌲", "🛎", "🌨"], bgColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), fgColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    private let people = Theme(emojis: ["💂🏻‍♀️", "👨🏻‍🎤", "🧕🏽", "👩🏻‍🔬", "👩🏼‍🏫", "👩🏾‍🚒", "🤴🏼", "👩🏾‍✈️"], bgColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), fgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    private let animals = Theme(emojis: ["🐶", "🐷", "🐺", "🦆", "🐙", "🐣", "🐞", "🐵"], bgColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), fgColor: #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1))
    private let countries = Theme(emojis: ["🇦🇴", "🇨🇳", "🇨🇦", "🇧🇴", "🇨🇼", "🇯🇵", "🇰🇷", "🇺🇸"], bgColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), fgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    private let tech = Theme(emojis: ["📱", "🖥", "🖨", "🎛", "📺", "📷", "💿", "🕹"], bgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), fgColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var newGameButton: UIButton!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        let cardNumber = cardButtons.index(of: sender)!
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    @IBAction private func startNewGame(_ sender: Any) {
        game.startGame(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = currentTheme.Emojis
        newGameButton.isEnabled = false
        newGameButton.isHidden = true
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Bonus 1
        for card in cardButtons {
            card.backgroundColor = currentTheme.cardColor
        }
        
        self.view.backgroundColor = currentTheme.backgroundColor
        scoreLabel.textColor = currentTheme.cardColor
        newGameButton.setTitleColor(currentTheme.cardColor, for: .normal)
    }
    
    private func updateScoreLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth : 3.0,
            .strokeColor : currentTheme.cardColor
        ]
        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    private func updateViewFromModel() {
        updateScoreLabel()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiForCard(for: card), for: UIControlState.normal)
                button.swapToColor(withDuration: 0.2, toColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
                button.isUserInteractionEnabled = false
            } else {
                button.setTitle("", for: UIControlState.normal)
                let toColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : currentTheme.cardColor
                button.swapToColor(withDuration: 0.2, toColor: toColor)
                button.isUserInteractionEnabled = !card.isMatched
            }
        }
        if game.isGameDone() {
            newGameButton.isEnabled = true
            newGameButton.isHidden = false
        }
    }
    
    private var emoji = [Card:String]()

    private func emojiForCard(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.arc4random
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card] ?? "?"
    }
}





