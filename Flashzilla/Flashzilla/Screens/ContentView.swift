//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tino on 8/4/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var showingEditScreen = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                TimeView(time: $timeRemaining)
                
                StackedCards(cards: cards, removal: removeCard)
                    .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            FloatingButton(action: { showingEditScreen = true })
            
            if differentiateWithoutColor || accessibilityEnabled {
                AccessibilityButtons(cards: cards, removal: removeCard)
            }
        }
        .onReceive(timer, perform: updateTime)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if !cards.isEmpty {
                isActive = true
            }
        }
        .onAppear(perform: resetCards)
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
    }
}

// MARK: Functions
extension ContentView {
    func removeCard(at index: Int) {
        if index < 0 { return }
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: EditCards.saveKey) {
            if let decodedCards = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decodedCards
            }
        }
    }
    
    func updateTime(date: Date) {
        if !isActive { return }
        if timeRemaining > 0 {
            timeRemaining -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
