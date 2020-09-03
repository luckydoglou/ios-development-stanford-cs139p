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
        
        return SetCardGame()
        
    }
    
}

struct CardContent {
    
    // enums for shape, shading
    var numberOfShapes: Int
    var colors: Color
    var shape: Shape
    var shading: Shading
    
    enum Shape {
        case rectangle
        case oval
        case diamond
    }
    enum Shading {
        case solid
        case semitransparent
        case clear
    }
    
}
