//
//  DiceRoller.swift
//  DiceRoll
//
//  Created by Tino on 10/4/21.
//

import Foundation

class DiceRoller: ObservableObject {
    @Published private(set) var results: [[Int]]
    @Published var dice: Dice
    @Published var rollCount: Int
    @Published var total: Int
    
    init(sides: Dice.DiceType = .six, rollCount: Int = 1) {
        results = []
        dice = Dice(sides: sides)
        self.rollCount = rollCount
        total = 0
    }
}

// MARK: Functions
extension DiceRoller {
    func roll() {
        var tempResults = [Int]()
        total = 0
        for _ in 0 ..< rollCount {
            let result = dice.roll()
            total += result
            tempResults.append(result)
        }
        results.append(tempResults)
        
    }
    
    var resultsString: String {
        if results.isEmpty {
            return "Roll to get a result"
        }
        return results.last!.map(String.init)
            .joined(separator: ", ")
    }
}
