//
//  SetCardGameView.swift
//  SetCardGame
//
//  Created by Lor Worwag on 8/18/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

class SetCardGameVM: ObservableObject {
    
    @Published private var model: SetCardGame = SetCardGameVM.createSetCardGame()
    
    // create Set card game
    private static func createSetCardGame() -> SetCardGame {
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
    
        return SetCardGame(numberOfCards: 81) { index in
            return cardContentArray[index]
        }
    }
    
    // MARK: - Access to the Model
    
    var presentCards: Array<SetCardGame.Card> {
        model.cardsShowing
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: SetCardGame.Card) {
        model.choose(card: card)
    }
    
    func dealCards(quantity: Int = 3) {
        model.dealCards(quantity)
    }
    
    func resetGame() {
        model = SetCardGameVM.createSetCardGame()
        dealCards(quantity: 12)
    }
}

