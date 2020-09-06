//
//  Cardify.swift
//  SetCardGame
//
//  Created by Lor Worwag on 9/4/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
        
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
            content.aspectRatio(0.7, contentMode: .fit)
        }
        .padding(5)
    }
}

extension View {
    func cardify() -> some View {
        self.modifier(Cardify())
    }
}
