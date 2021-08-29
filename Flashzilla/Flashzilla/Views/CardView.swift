//
//  CardView.swift
//  Flashzilla
//
//  Created by Tino on 29/8/21.
//

import SwiftUI

struct CardView: View {
    var card: Card
    @State private var position = CGSize()
    @State private var isDragging = false
    @State private var showingAnswer = false
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    Text(card.question)
                    if showingAnswer {
                        Text(card.answer)
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .padding()
            .foregroundColor(isDragging ? .green : .red)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 5)
            .rotationEffect(Angle(degrees: Double(position.width) * 0.2))
            .offset(position)
            .onTapGesture {
                print("tapped")
                withAnimation {
                    showingAnswer.toggle()
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { _ in
                        isDragging = false
                        if abs(position.width) > proxy.size.width / 2 {
                            if position.width < 0 {
                                userData.incorrectCount += 1
                            } else {
                                userData.correctCount += 1
                            }
                            print(card)
                            
                            userData.remove(card)
                        }
                        withAnimation {
                            position = CGSize()
                        }
                    }
                    .onChanged { value in
                        withAnimation {
                            position.width = value.translation.width
                        }
                        isDragging = true
                    }
            )
        }
        .frame(width: 300, height: 150)
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(question: "test", answer: "testing"))
    }
}
