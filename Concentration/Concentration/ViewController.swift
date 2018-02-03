//
//  ViewController.swift
//  Concentration
//
//  Created by Changyu Yan on 11/17/17.
//  Copyright © 2017 Changyu Yan. All rights reserved.
//  Stanford Lecture

import UIKit

class ViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    // Note: Lazy cannot have a didSet!!!
    
    var numberOfPairsOfCards: Int
    {
        return (cardButtons.count+1)/2 // Read-only
    }
    
    private(set) var flipCount = 0
    {
        // Every time it changes, label gets updated
        didSet
        {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var hiddenButtons = 0
    
    @IBOutlet private weak var congrats: UILabel!
    
    @IBOutlet private weak var flipCountLabel: UILabel! // Notice this does not need to be initialized
    
    @IBOutlet private var cardButtons: [UIButton]! // Array of UI Button

    
    @IBAction func touchCard(_ sender: UIButton)
    {
        if let cardNumber = cardButtons.index(of: sender)
        {
            game.chooseCard(at: cardNumber)
            if cardButtons[cardNumber].backgroundColor != #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0)
            {
                flipCount += 1
            }
            updateViewFromModel()
        }
        else
        {
            print("Chosen card was not in cardButtons")
        }
        
    }
    
    private func updateViewFromModel()
    {
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp
            {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
            else
            {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
        if finishedGame()
        {
            congrats.isHidden = false
        }
    }
    
    private var emojiChoices = ["🎃", "👻", "🍭", "👹", "🦇", "😈", "🍎", "🍫", "🍪"]
    
    private var emoji = [Int: String]()
    
    private func emoji(for card:Card) -> String
    {
        // if emoji[card.identifier] != nil{
        // return emoji[card.identifier]!
        // }else{
        // return "?"
        // }
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0
        {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex) // remove returns the item
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func finishedGame() -> Bool
    {
        for button in cardButtons
        {
            if button.backgroundColor == #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            {
                return false
            }
        }
    
        return true
    }
    
}

