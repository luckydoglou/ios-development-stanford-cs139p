//
//  SetCardGame.swift
//  SetCardGame
//
//  Created by Lor Worwag on 8/18/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import Foundation

struct SetCardGame<Content> {
//    var cards: Array<Card>
    
    init() {
        
    }
    
    
    func choose() {
        
    }
    
    
    struct Card: Identifiable {
        
        var id: Int
        var isSelected: Bool = false
        var isMatched: Bool = false
        var content: Content
//        var number: int
//        var shape: Shape
//        var shading: Shape
//        var color: Color
        
    }
    
}
