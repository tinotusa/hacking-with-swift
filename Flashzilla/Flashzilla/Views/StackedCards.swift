//
//  StackedCards.swift
//  Flashzilla
//
//  Created by Tino on 9/4/21.
//

import SwiftUI

struct StackedCards: View {
    let cards: [Card]
    let removal: ((Int) -> Void)?
    
    var body: some View {
        ZStack {
            ForEach(0..<cards.count, id: \.self) { index in
                CardView(card: cards[index]) {
                   withAnimation {
                       removal?(index)
                   }
                }
                .stacked(at: index, in: cards.count)
                .allowsHitTesting(index == cards.count - 1)
                .accessibility(hidden: index < cards.count - 1)
            }
        }
    }
}

struct StackedCards_Previews: PreviewProvider {
    static var previews: some View {
        StackedCards(cards: [Card](repeating: Card.example, count: 4), removal: nil)
    }
}
