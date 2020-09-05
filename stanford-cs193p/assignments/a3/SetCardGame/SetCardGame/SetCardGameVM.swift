//
//  SetCardGameView.swift
//  SetCardGame
//
//  Created by Lor Worwag on 8/18/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

class SetCardGameVM {
    
    var model: SetCardGame<CardContent> = SetCardGameVM.createSetCardGame()
    
    // create Set card game
    static func createSetCardGame() -> SetCardGame<CardContent> {
        var cardContentArray = Array<CardContent>()
        for number in CardContent.Number.allCases {
            for colour in CardContent.Colour.allCases {
                for shape in CardContent.Shapes.allCases {
                    for shading in CardContent.Shading.allCases {
                        cardContentArray.append(CardContent(numberOfShapes: number, colour: colour, shape: shape, shading: shading))
                    }
                }
            }
        }
    
        return SetCardGame<CardContent>(numberOfCards: 12) { index in
            return cardContentArray[index]
            
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<SetCardGame<CardContent>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: SetCardGame<CardContent>.Card) {
        model.choose(card: card)
    }
}


