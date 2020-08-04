//
//  EmojiMemoryGame.swift
//  a1
//
//  Created by Lor Worwag on 8/3/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    static func createMemoryGame() -> MemoryGame<String> {
        // create emojis array
        var emojis: Array<String> = Array<String>()
        for i in 0x1F600...0x1F64F {
            emojis.append(String(Unicode.Scalar(i)!))
        }
        
        // initialize memory game
        return MemoryGame<String> (numberOfPairsOfCards: Int.random(in: 2...5)) { _ in
            return emojis[Int.random(in: 0...emojis.count)]
        }
    }
    
    /**
    // Alternative way to initialize the game
    private var model: MemoryGame<String>

    init() {
        let emojis = ["👻", "🎃", "🤡"]
        model = MemoryGame<String> (numberOfPairsOfCards: emojis.count) {pairIndex in
            return emojis[pairIndex]
        }
    }
    */
    
    
    // MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}
