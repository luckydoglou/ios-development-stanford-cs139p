//
//  MemoryGame.swift
//  a2
//
//  Created by Lor Worwag on 8/5/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<CardType> where CardType: Equatable {
    
    var cards: Array<Card>
    var themeName: String
    var themeColor: LinearGradient
    var points: Int
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, themeName: String, themeColor: LinearGradient, cardContent: (Int) -> CardType) {
        cards = Array<Card>()
        self.themeName = themeName
        self.themeColor = themeColor
        points = 0
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let cardContent = cardContent(pairIndex)
            cards.append(Card(content: cardContent, id: pairIndex*2))
            cards.append(Card(content: cardContent, id: pairIndex*2+1))
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
                    points += 2
                } else {
                    if cards[chosenIndex].hasSeen { points -= 1 }
                    if cards[potentialMatchedIndex].hasSeen { points -= 1 }
                    cards[chosenIndex].hasSeen = true
                    cards[potentialMatchedIndex].hasSeen = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardType
        var id: Int
        var hasSeen: Bool = false
        
    }
    
}
