//
//  CardContent.swift
//  SetCardGame
//
//  Created by Lor Worwag on 9/4/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import Foundation

struct CardContent {
    // enums for shape, shading
    var numberOfShapes: Number
    var colour: Colour
    var shape: Shapes
    var shading: Shading

    enum Number: Int, CaseIterable {
        case one = 1
        case two
        case three
    }

    enum Colour: String, CaseIterable {
        case red
        case blue
        case green
    }

    enum Shapes: String, CaseIterable {
        case circle
        case triangle
        case diamond
    }
    
    enum Shading: String, CaseIterable {
        case solid
        case stripped
        case clear
    }
}
