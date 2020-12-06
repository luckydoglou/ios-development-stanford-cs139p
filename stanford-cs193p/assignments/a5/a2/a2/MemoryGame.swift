//
//  MemoryGame.swift
//  a2
//
//  Created by Lor Worwag on 8/5/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<CardType>: Codable where CardType: Equatable, CardType: Codable {
    
    var cards: Array<Card>
    var theme: Theme
    var gamePoints: Int
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    private var uniqueThemeId = 0
    var json: Data? {
        try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let newMemoryGame = try? JSONDecoder().decode(MemoryGame.self, from: json!) {
            self = newMemoryGame
        } else {
            return nil
        }
    }
    
    init(themeName: String, themeContent: Array<CardType>, numberOfPairsOfCards: Int, cardContent: (Int) -> CardType) {
        cards = Array<Card>()
        uniqueThemeId += 1
        theme = Theme(id: uniqueThemeId, name: themeName, content: themeContent)
        gamePoints = 0
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let cardContent = cardContent(pairIndex)
            cards.append(Card(id: pairIndex*2, content: cardContent))
            cards.append(Card(id: pairIndex*2+1, content: cardContent))
        }
        cards.shuffle()
    }
    
    
    mutating func choose(card: Card) {
        print(card)
        
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchedIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchedIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchedIndex].isMatched = true
                    gamePoints += 2
                } else {
                    if cards[chosenIndex].hasSeen { gamePoints -= 1 }
                    if cards[potentialMatchedIndex].hasSeen { gamePoints -= 1 }
                    cards[chosenIndex].hasSeen = true
                    cards[potentialMatchedIndex].hasSeen = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    struct Card: Identifiable, Codable {
        var id: Int
        var content: CardType
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasSeen: Bool = false
        
    }
    
    struct Theme: Identifiable, Codable {
        var id: Int
        var name: String
        var color: RGBA
        var content: Array<CardType>
        
        
        fileprivate init(id: Int, name: String, content: Array<CardType>) {
            self.id = id
            self.name = name
            self.content = content
            self.color = RGBA(red: 255, green: 255, blue: 255, alpha: 1)
        }
        
        struct RGBA: Codable {
            var red: Double = 255
            var green: Double = 255
            var blue: Double = 255
            var alpha: Double = 1
        }
        
    }
    
}
