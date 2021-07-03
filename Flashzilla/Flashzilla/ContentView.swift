//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tino on 8/4/21.
//

import SwiftUI

// MARK: -- TODO
// remove cards when swiped
//

class UserData: ObservableObject {
    var correctCount = 0
    var incorrectCount = 0
    @Published var currentQuestion = 0
    
    private(set) var cards: [Card] = [
        Card(question: "hello a", answer: "answer a"),
        Card(question: "hello b", answer: "answer b"),
        Card(question: "hello c", answer: "answer c")
    ]
    
    init() {
        load()
    }
    
    func load() {
        // todo
    }
    
    func save() {
        // todo
    }
    
    var totalCards: Int {
        return cards.count
    }
    
    var currentCard: Card {
        cards[currentQuestion]
    }
}

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
                            // remove card
                            userData.currentQuestion += 1
                            print(userData.currentQuestion)
                            if position.width < 0 {
                                userData.incorrectCount += 1
                            } else {
                                userData.correctCount += 1
                            }
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

struct Card: Codable, Identifiable {
    let id = UUID()
    
    enum CodingKeys: CodingKey {
        case question, answer
    }
    let question: String
    let answer: String
}

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            // show cards
            VStack {
                ForEach(userData.cards.indices) { index in
                    CardView(card: userData.cards[index])
                }
            }
            if userData.currentQuestion >= userData.totalCards {
                Text("game over")
            }
        }
        .background(Color.gray)
        // create card information
        // add swipe to answer
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
