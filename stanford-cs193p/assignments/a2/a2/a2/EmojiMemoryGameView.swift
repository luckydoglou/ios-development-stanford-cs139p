//
//  ContentView.swift
//  a2
//
//  Created by Lor Worwag on 8/5/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            Button(action: viewModel.startANewGame) {
                Text("New Game")
            }
                .padding()
            HStack {
                Spacer()
                Text("\(viewModel.themeName) Theme")
                Spacer()
                Text("Points: \(viewModel.points)")
                Spacer()
            }
            Grid(viewModel.cards) { card in
                CardView(card: card, themeColor: self.viewModel.themeColor).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                    .padding(5)
            }
                .padding(.bottom)
            
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var themeColor: LinearGradient
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(themeColor)
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
