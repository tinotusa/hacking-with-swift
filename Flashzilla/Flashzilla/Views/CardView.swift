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
    @EnvironmentObject var settingsData: SettingsData
    
    private let hapticEngine = HapticEngine()
    private var width: CGFloat { UIScreen.main.bounds.width < 600 ? 400 : 600 }
    private var height: CGFloat { UIScreen.main.bounds.height < 400 ? 200 : 300 }
    
    var body: some View {
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
        .frame(width: width, height: height)
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
        .gesture(dragGesture())
    }
}

// MARK: - Private Implementation
private extension CardView {
    func dragGesture() -> some Gesture {
        DragGesture()
            .onEnded { _ in
                isDragging = false
                if abs(position.width) > UIScreen.main.bounds.width / 4 {
                    if position.width < 0 {
                        userData.incorrectCount += 1
                        if settingsData.haptics {
                            hapticEngine.playHaptic()
                        }
                    } else {
                        userData.correctCount += 1
                        if !settingsData.mute {
                            AudioPlayer.playAudio("correct.wav")
                        }
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
