//
//  Game.swift
//  Flashzilla
//
//  Created by Tino on 29/8/21.
//

import Foundation

final class UserData: ObservableObject {
    private static var saveFileName = "cards.data"
    private static var defaultTime = SettingsData.defaultTimeLimit
    
    var correctCount = 0
    var incorrectCount = 0
    var totalCards = 0
    
    @Published var gameIsOver = false
    var totalTime = defaultTime
    @Published var timeRemaining: Int = defaultTime {
        willSet {
            if newValue <= 0 {
                gameIsOver = true
            }
        }
    }
    
    // model
    @Published private(set) var cards: [Card] = []
    
    init() {
        load()
    }
    
    func update(_ settings: Settings) {
        totalTime = settings.timeLimit
        timeRemaining = totalTime
    }
    
    func remove(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards.remove(at: index)
            if cards.isEmpty {
                gameIsOver = true
            }
        }
    }
    
    func remove(atOffsets offsets: IndexSet) {
        offsets.forEach { cards.remove(at: $0) }
        save()
    }
    
    
    func addCard(_ card: Card) {
        cards.append(card)
        save()
    }
    
    func reset() {
        load()
        correctCount = 0
        incorrectCount = 0
        timeRemaining = totalTime
        gameIsOver = false
    }
    
    func index(of card: Card) -> Int {
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else {
            fatalError("Error: \(#function)\nCard not found in cards")
        }
        return index
    }
}

// MARK: - Private Implementation
private extension UserData {
    func load() {
        guard var saveFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: \(#function)\nFailed to get documents directory")
            return
        }
        do {
            saveFileURL = saveFileURL.appendingPathComponent(Self.saveFileName)
            let data = try Data(contentsOf: saveFileURL)
            cards = try JSONDecoder().decode([Card].self, from: data)
            totalCards = cards.count
            cards.shuffle()
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
    
}
