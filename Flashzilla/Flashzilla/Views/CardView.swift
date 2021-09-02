//
//  CardView.swift
//  Flashzilla
//
//  Created by Tino on 29/8/21.
//

import SwiftUI
import AVFoundation

struct CardView: View {
    var card: Card
    @State private var position = CGSize()
    @State private var isDragging = false
    @State private var showingAnswer = false
    @EnvironmentObject var userData: UserData
    private let hapticEngine = HapticEngine()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    Text(card.question)
                        .font(.title)
                    if showingAnswer {
                        Text(card.answer)
                    }
                }
            }
            .padding()
            .frame(width: width(in: proxy), height: height(in: proxy))
            .foregroundColor(Color("textColour"))
            .background(Color("foreground"))
            .cornerRadius(20)
            .shadow(color: .black, radius: 5, x: 0, y: 1)
            .rotationEffect(Angle(degrees: Double(position.width) * 0.2))
            .offset(position)
            .onTapGesture {
                withAnimation {
                    showingAnswer.toggle()
                }
            }
            .gesture(dragGesture(proxy: proxy))
        }
    }
}

// MARK: - Private Implementation
private extension CardView {
    func width(in proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).width * 0.7
    }
    
    func height(in proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).height * 0.8
    }
    
    func dragGesture(proxy: GeometryProxy) -> some Gesture {
        DragGesture()
            .onEnded { _ in
                isDragging = false
                if abs(position.width) > proxy.size.width / 2 {
                    if position.width < 0 {
                        userData.incorrectCount += 1
                        hapticEngine.playHaptic()
                    } else {
                        userData.correctCount += 1
                        AudioPlayer.playAudio("correct.wav")
                    }
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
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse aliquam tortor eu euismod pulvinar. Maecenas et laoreet leo, vitae dictum odio. Donec pellentesque ex ut euismod bibendum.", answer: "testing"))
            .environmentObject(UserData())
    }
}
