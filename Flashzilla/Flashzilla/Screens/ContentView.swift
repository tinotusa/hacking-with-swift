//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tino on 8/4/21.
//

import SwiftUI
import CoreHaptics
import AVKit

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    static let maxTime = 20
    
    @State private var cards = [Card]()
    @State private var timeRemaining = Self.maxTime
    @State private var isActive = true
    @State private var showingEditScreen = true
    @State private var showingSettingsScreen = false
    @State private var shouldRepeatQuestions = false
    @State private var isWrong = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            ZStack {
                VStack {
                    TimeView(time: $timeRemaining)
                    
                    StackedCards(cards: cards, removal: removeCard)
                        .allowsHitTesting(timeRemaining > 0)
                }
                
                FloatingButton(image: Image(systemName: "plus.circle"), position: .topTrailing, action: { showingEditScreen = true })
                
                FloatingButton(image: Image(systemName: "square.and.pencil"), position: .topLeading, action: { showingSettingsScreen = true })
                
                if differentiateWithoutColor || accessibilityEnabled {
                    AccessibilityButtons(cards: cards, removal: removeCard)
                }
                
                if cards.isEmpty || timeRemaining == 0 {
                    Color.black.opacity(0.6)
                        .transition(.opacity)
                        .edgesIgnoringSafeArea(.all)
                }
                
                if cards.isEmpty || timeRemaining == 0 {
                    Button("Start again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
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
        .sheet(isPresented: $showingSettingsScreen, onDismiss: resetCards) {
            Settings(shouldRepeat: $shouldRepeatQuestions)
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
        timeRemaining = Self.maxTime
        isActive = true
        timer = timer.upstream.autoconnect()
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: EditCards.saveKey) {
            if let decodedCards = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decodedCards
                print(cards.count)
            }
        }
    }
    
    func updateTime(date: Date) {
        if !isActive { return }
        prepareHaptics()
        
        if timeRemaining <= 0 {
            playTimeUpHaptic()
            timer.upstream.connect().cancel()
            return
        }
        timeRemaining -= 1
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
//            print("the device doesn't support haptics")
            return
        }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("failed to start engine")
        }
    }
    
    func playTimeUpHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
