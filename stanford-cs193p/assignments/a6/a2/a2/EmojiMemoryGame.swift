//
//  EmojiMemoryGame.swift
//  a2
//
//  Created by Lor Worwag on 8/5/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject, Identifiable {
    
    @Published private var memoryGame: MemoryGame<String>
    
    let id: UUID
    static var fruits: Array<String> = ["🍇", "🍉", "🍌", "🍓"]
//    stavar themeName: String = "Untitled"
    
    init (id: UUID? = nil) {
        self.id = id ?? UUID()
        let defaultKey = "MemoryGame.\(self.id.uuidString)"
        memoryGame = MemoryGame<String>(json: UserDefaults.standard.data(forKey: defaultKey)) ?? MemoryGame<String>(themeName: "Untitled", themeContent: EmojiMemoryGame.fruits, numberOfPairsOfCards: 4) { pairIndex in
            return EmojiMemoryGame.fruits[pairIndex]
        }
    }
    

    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        memoryGame.cards
    }
    
    var points: Int {
        memoryGame.gamePoints
    }
    
    var themeName: String {
        memoryGame.theme.name
    }
    
    var themeColor: Color {
        memoryGame.theme.themeColor
    }
    
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        memoryGame.choose(card: card)
    }
    
    func startANewGame() {
        // TODO
        //memoryGame = EmojiMemoryGame.createMemoryGame()
    }
    
}


// MARK: - Extensions
extension MemoryGame.Theme {
    // convert Theme.color to Color type
    var themeColor: Color {
        Color(UIColor.RGBA(red: CGFloat(color.red),
                           green: CGFloat(color.green),
                           blue: CGFloat(color.blue),
                           alpha: CGFloat(color.alpha)))
    }
}

extension Color {
    // converting RGBA UIColor to Color
    init(_ rgba: UIColor.RGBA) {
        self.init(UIColor(rgba))
    }
}

extension UIColor {
    // converting RGBA Doubles to RBGA CGFloats
    public struct RGBA {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var alpha: CGFloat
    }
    
    // converting RGBA CGFloats to UIColor
    convenience init(_ rgba: RGBA) {
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
    
    // default values for RGBA
//    public var rgba: RGBA {
//        var red: CGFloat = 0
//        var green: CGFloat = 0
//        var blue: CGFloat = 0
//        var alpha: CGFloat = 0
//        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//        return RGBA(red: red, green: green, blue: blue, alpha: alpha)
//    }
    
}
