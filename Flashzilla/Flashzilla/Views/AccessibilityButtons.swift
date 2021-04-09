//
//  AccessibilityButtons.swift
//  Flashzilla
//
//  Created by Tino on 9/4/21.
//

import SwiftUI

struct AccessibilityButtons: View {
    let cards: [Card]
    let removal: (Int) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    withAnimation {
                        removal(cards.count - 1)
                    }
                }) {
                    Image(systemName: "xmark.circle")
                        .blackCircleImage()
                }
                .accessibility(label: Text("Wrong"))
                .accessibility(hint: Text("Mark your answer as being incorrect."))
                Spacer()
                Button(action: {
                    withAnimation {
                        removal(cards.count - 1)
                    }
                }) {
                    Image(systemName: "checkmark.circle")
                        .blackCircleImage()
                }
                .accessibility(label: Text("Correct"))
                .accessibility(hint: Text("Mark your answer as being correct."))
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
        }
    }
}

struct AccessibilityButtons_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityButtons(cards: [Card](repeating: Card.example, count: 3), removal: {_ in})
    }
}
