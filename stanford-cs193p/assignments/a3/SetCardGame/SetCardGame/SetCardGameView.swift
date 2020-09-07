//
//  ContentView.swift
//  SetCardGame
//
//  Created by Lor Worwag on 8/18/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var viewModel: SetCardGameVM
    
    var body: some View {
        VStack {
            // top panel, buttons & score
            HStack {
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.resetGame()
                    }
                }, label: { Text("New Game") })
                .padding(.trailing)
                
                Divider().frame(height: 30)
                
                Text("Score: \(viewModel.score)")
                    .padding([.leading, .trailing])
                    .fixedSize(horizontal: true, vertical: false)
                
                Divider().frame(height: 30)
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.dealCards()
                    }
                }, label: { Text("Add Cards") })
                    .padding(.leading)
            }
            .padding(.top)
            
            // cards
            Grid(viewModel.presentCards) { card in
                CardView(card: card)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.viewModel.choose(card: card)
                        }
                    }
            }
            .padding(5)
            .onAppear {
                withAnimation(.easeIn(duration: 2)) {
                    self.viewModel.dealCards(quantity: 12)
                }
            }
        
        }
    }
    
}

struct CardView: View {
    var card: SetCardGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        DrawingCardContent(content: card.content)
            .cardify(of: card)
    }
    
}

