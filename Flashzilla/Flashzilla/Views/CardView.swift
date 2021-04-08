//
//  CardView.swift
//  Flashzilla
//
//  Created by Tino on 8/4/21.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil

    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()

    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(fill)
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(rotationAmount)
        .offset(x: offsetAmount, y: 0)
        .opacity(2 - opacityAmount)
        .accessibility(addTraits: .isButton)
        .onTapGesture { isShowingAnswer.toggle() }
        .animation(.spring())
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width < 0 {
                            feedback.notificationOccurred(.error)
                        }
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
    }
}

extension CardView {
    var rotationAmount: Angle {
        .degrees(Double(offset.width / 5))
    }
    
    var offsetAmount: CGFloat {
        offset.width * 1.5
    }
    
    var opacityAmount: Double {
        Double(abs(offset.width / 75))
    }
    
    var fill: Color {
        if differentiateWithoutColor {
            return .white
        }
        return Color.white.opacity(1 - opacityAmount)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
