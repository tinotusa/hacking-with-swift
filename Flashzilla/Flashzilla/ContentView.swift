//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tino on 8/4/21.
//

// MARK: - TODO
// add sounds (maybe haptics when incorrect)
// move extensions (code clean up)
// make ui pretty

import SwiftUI

extension View {
    func appEnteredBackground(_ action: (() -> Void)?) -> some View {
        self
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                action?()
            }
    }
}

extension View {
    func appEnteredForeground(_ action: (() -> Void)?) -> some View {
        self
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                action?()
            }
    }
}


struct Stacked: ViewModifier {
    let index: Int
    let total: Int
    let offsetAmount = 10
    func body(content: Content) -> some View {
        content
            .offset(x: 0, y: CGFloat(total - index * offsetAmount))
    }
}

extension View {
    func stacked(index: Int, total: Int) -> some View {
        self.modifier(Stacked(index: index, total: total))
    }
}

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State private var showingEditScreen = false
    @State private var timeIsPaused = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            // show cards
            VStack {
                ZStack {
                    ForEach(userData.cards) { card in
                        CardView(card: card)
                            .stacked(index: userData.index(of: card), total: userData.totalCards)
                            .disabled(userData.index(of: card) < userData.cards.count - 1)
                    }
                }
            }
            .disabled(userData.gameIsOver)
            
            countdownTimer
            editQuestionsButton
            resetButton
            
            if userData.gameIsOver {
                GameOverView() {
                    userData.reset()
                }
            }
        }
        .sheet(isPresented: $showingEditScreen) {
            EditScreen()
        }
        .onReceive(timer) { _ in
            if timeIsPaused || userData.gameIsOver {
                return
            }
            if userData.timeRemaining > 0 {
                userData.timeRemaining -=  1
            }
        }
        .appEnteredBackground {
            timeIsPaused = true
        }
        .appEnteredForeground {
            timeIsPaused = false
        }
    }
    
    private func getIndex(of card: Card, in cards: [Card]) -> Int? {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            return index
        }
        return nil
    }
    
    private var editQuestionsButton: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    showingEditScreen = true
                } label: {
                    Text("edit questions")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
            Spacer()
        }
        .padding(.vertical)
    }
    
    private var resetButton: some View {
        VStack {
            HStack {
                Button {
                    userData.reset()
                } label: {
                    Text("Reset")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.vertical)
    }
    
    private var formattedTime: String {
        let minutes = userData.timeRemaining / 60
        let seconds = userData.timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private var countdownTimer: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(formattedTime)")
                    .font(.largeTitle)
                Spacer()
            }
            Spacer()
        }
        .padding(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
