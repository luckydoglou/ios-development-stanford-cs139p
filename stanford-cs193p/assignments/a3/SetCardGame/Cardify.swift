//
//  Cardify.swift
//  SetCardGame
//
//  Created by Lor Worwag on 9/4/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var card: SetCardGame.Card
    
    func body(content: Content) -> some View {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                    .foregroundColor(Color.gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(lineWidth: edgeLineWidth)
                            .foregroundColor(Color.yellow)
                            .opacity(card.isSelected ? 1 : 0)
                    )
                content.aspectRatio(0.7, contentMode: .fit)
            }
            .padding(5)
    }
}

// MARK: - Constants

private let cornerRadius: CGFloat = 10.0
private let edgeLineWidth: CGFloat = 3.0

// MARK: - Cardify Extension

extension View {
    func cardify(of card: SetCardGame.Card) -> some View {
        self.modifier(Cardify(card: card))
    }
}


