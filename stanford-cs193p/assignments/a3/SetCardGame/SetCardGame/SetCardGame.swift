//
//  SetCardGame.swift
//  SetCardGame
//
//  Created by Lor Worwag on 8/18/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import Foundation

struct SetCardGame {
    var cards: Array<Card>
    var cardsShowing: Array<Card> {
        get {cards.filter { $0.isShowing }}
    }
    var selectedCards: Array<Card> {
        get { cardsShowing.filter { $0.isSelected }}
    }
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
//        cardsShowing = Array<Card>()
        for index in 0..<numberOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(id: index, content: content))
        }
        cards.shuffle()
        for index in 0..<12 {
            cards[index].isShowing = true
//            cardsShowing.append(cards[index])
//            cards.remove(at: index)
        }
    }
    
    mutating func choose(card: Card) {
        
        for index in cards.indices {
            if cards[index].id == card.id {
                cards[index].isSelected.toggle()
            }
        }
        
        if selectedCards.count == 3 {
            checkMatching()
        }
        print(card)
    }
    
    mutating func checkMatching() {
        if isSet(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2]) {
            discardSelectedCards()
        } else {
            deselectAllCards()
        }
    }
    
    // checkMatching() helper function 1
    func isSet(card1: Card, card2: Card, card3: Card) -> Bool {
        return isFeatureASet(contentA: card1.content.numberOfShapes,
                             contentB: card2.content.numberOfShapes,
                             contentC: card3.content.numberOfShapes) &&
                isFeatureASet(contentA: card1.content.colour,
                              contentB: card2.content.colour,
                              contentC: card3.content.colour) &&
                isFeatureASet(contentA: card1.content.shape,
                              contentB: card2.content.shape,
                              contentC: card3.content.shape) &&
                isFeatureASet(contentA: card1.content.shading,
                              contentB: card2.content.shading,
                              contentC: card3.content.shading)
    }
    
    // checkMatching() helper function 2
    func isFeatureASet<Content: Equatable>(contentA: Content, contentB: Content, contentC: Content) -> Bool {
        return (contentA == contentB && contentB == contentC) ||
            (contentA != contentB && contentB != contentC && contentC != contentA)
    }
    
    mutating func discardSelectedCards() {
//        for i in cardsShowing.indices {
//            for j in selectedCards.indices {
//                if cardsShowing[i].id == selectedCards[j].id {
//                    cardsShowing.remove(at: i)
//                }
//            }
//        }
        for index in cards.indices {
            if cards[index].isSelected {
                cards[index].isShowing = false
                cards[index].isSelected = false
                cards[index].isMatched = true
            }
        }
        dealCards()
    }
    
    mutating func deselectAllCards() {
        for index in cards.indices {
            cards[index].isSelected = false
        }
    }
    
    mutating func dealCards(_ quantity: Int = 3) {
//        for index in 0..<quantity {
//            if cards.count > 0 {
//                cardsShowing.append(cards[index])
//                cards.remove(at: index)
//            }
//        }
        var count = 0
        for index in cards.indices {
            if (count < quantity) && (!cards[index].isMatched) && (!cards[index].isShowing) {
                cards[index].isShowing = true
                count += 1
            }
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var content: CardContent
        var isShowing: Bool = false
        var isSelected: Bool = false
        var isMatched: Bool = false
    }
    
}


