//
//  EmojiMemoryGame.swift
//  a2
//
//  Created by Lor Worwag on 8/5/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
//    static var randomTheme: Themes.Theme = Themes.getRandomTheme()
//    var themeName: String
    static var themeColor: LinearGradient?
    
    static func createMemoryGame() -> MemoryGame<String> {
        let randomTheme = Themes.getRandomTheme()
        themeColor = randomTheme.color
        
        return MemoryGame<String>(numberOfPairsOfCards: randomTheme.content.count, themeName: randomTheme.name, themeColor: randomTheme.color) { pairIndex in
            return randomTheme.content[pairIndex]
        }
    }

    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeName: String {
        model.themeName
    }
    
    var themeColor: LinearGradient {
        model.themeColor
    }
    
    var points: Int {
        model.points
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func startANewGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}

