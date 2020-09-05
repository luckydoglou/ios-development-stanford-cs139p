//
//  SetCardGame.swift
//  SetCardGame
//
//  Created by Lor Worwag on 8/18/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import Foundation

struct SetCardGame<CardContent> {
    var cards: Array<Card>
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(id: index, content: content))
        }
    }
    
    
    func choose(card: Card) {
        print(card)
    }
    
    func checkMatching() {
        
    }
    
    struct Card: Identifiable {
        
        var id: Int
        var content: CardContent
        var isShowing: Bool = false
        var isSelected: Bool = false
        var isMatched: Bool = false

        
    }
    
}
