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
            Grid(viewModel.presentCards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
            .padding(5)
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
    
    func body(for size: CGSize) -> some View {
        DrawingCardContent(content: card.content)
            .cardify()
    }
    
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetCardGameView(viewModel: SetCardGameVM())
    }
}
