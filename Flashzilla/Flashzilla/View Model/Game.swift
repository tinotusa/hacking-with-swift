//
//  Game.swift
//  Flashzilla
//
//  Created by Tino on 29/8/21.
//

import Foundation

class UserData: ObservableObject {
    var correctCount = 0
    var incorrectCount = 0
    var totalCards = 0
    static var saveFileName = "cards.data"
    
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
        guard var saveFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: \(#function)\nFailed to get documents directory")
            return
        }
        do {
            saveFileURL = saveFileURL.appendingPathComponent(Self.saveFileName)
            let data = try Data(contentsOf: saveFileURL)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch CocoaError.fileReadNoSuchFile {
            // do nothing
        } catch {
            print(error)
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(cards)
            var saveFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            saveFileURL = saveFileURL.appendingPathComponent(Self.saveFileName)
            try data.write(to: saveFileURL, options: [.atomic, .completeFileProtection])
        } catch {
            print("error: \(error.localizedDescription)")
        }
        
    }
    
    func remove(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards.remove(at: index)
        }
    }
    
    func remove(atOffsets offsets: IndexSet) {
        offsets.forEach { cards.remove(at: $0) }
        save()
    }
    
    func reset() {
        load()
    }
    
    func addCard(_ card: Card) {
        cards.append(card)
        save()
    }
}
