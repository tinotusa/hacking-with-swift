//
//  Game.swift
//  Flashzilla
//
//  Created by Tino on 29/8/21.
//

import Foundation


// MARK: -- TODO
// remove cards when swiped
//

class UserData: ObservableObject {
    var correctCount = 0
    var incorrectCount = 0
    var totalCards = 0
    
    // model
    @Published private(set) var cards: [Card] = [
        Card(question: "hello a", answer: "answer a"),
        Card(question: "hello b", answer: "answer b"),
        Card(question: "hello c", answer: "answer c")
    ]
    
    init() {
        load()
        totalCards = cards.count
    }
    
    func load() {
        // todo
    }
    
    func save() {
        // todo
    }
    
    func remove(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards.remove(at: index)
        }
    }
    
    func remove(atOffsets offsets: IndexSet) {
        offsets.forEach { cards.remove(at: $0) }
    }
    
    func reset() {
        cards = [
            Card(question: "hello a", answer: "answer a"),
            Card(question: "hello b", answer: "answer b"),
            Card(question: "hello c", answer: "answer c")
        ]
    }
    
    func addCard(_ card: Card) {
        cards.append(card)
    }
}
