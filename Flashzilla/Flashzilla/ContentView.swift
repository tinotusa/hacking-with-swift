//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tino on 8/4/21.
//

// MARK: - TODO
// make ui pretty
// fix different sizes
// add the ability to change the running time

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State private var showingEditScreen = false
    @State private var timeIsPaused = false
    private let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            if userData.cards.isEmpty {
                VStack {
                    Text("No flash cards added.")
                    Text("Tap the pencil button to add cards.")
                }
                .font(.title)
                .foregroundColor(Color("textColour"))
            }
            
            // show cards
            VStack {
                HStack {
                    resetButton
                    Spacer()
                    countdownTimer
                    Spacer()
                    editQuestionsButton
                }
                .padding()
                
                Spacer()
            
                ZStack {
                    ForEach(userData.cards) { card in
                        CardView(card: card)
                            .stacked(index: userData.index(of: card), total: userData.totalCards)
                            .disabled(!isTopCard(card))
                    }
                }
            }
            .disabled(userData.gameIsOver)
            
            if userData.gameIsOver {
                GameOverView()
            }
        }
        .sheet(isPresented: $showingEditScreen) {
            EditScreen()
                .environmentObject(userData)
        }
        .onReceive(timer) { _ in
            // DON'T update the time if
            // the time is paused
            // or there are no flash cards
            // or the game is over
            if timeIsPaused || userData.cards.isEmpty || userData.gameIsOver {
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
}

// MARK: - Private Implementaion
private extension ContentView {
    func isTopCard(_ card: Card) -> Bool {
        userData.index(of: card) == userData.cards.count - 1
    }
    
    func getIndex(of card: Card, in cards: [Card]) -> Int? {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            return index
        }
        return nil
    }
    
    var editQuestionsButton: some View {
        Button {
            showingEditScreen = true
        } label: {
            Image(systemName: "pencil")
        }
        .buttonStyle(PurpleIconButtonStyle())
        
    }
    
    var resetButton: some View {
        Button {
            userData.reset()
        } label: {
            Image(systemName: "arrow.clockwise")
        }
        .buttonStyle(PurpleIconButtonStyle())

    }
    
    var formattedTime: String {
        let minutes = userData.timeRemaining / 60
        let seconds = userData.timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var countdownTimer: some View {
        Text("\(formattedTime)")
            .font(.largeTitle)
            .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
