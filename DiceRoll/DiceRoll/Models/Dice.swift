//
//  Dice.swift
//  DiceRoll
//
//  Created by Tino on 10/4/21.
//

import Foundation

struct Dice {
    private var _sides: DiceType
    
    enum DiceType: Int, CaseIterable {
        case four = 4, six = 6, eight = 8, ten = 10, twelve = 12, twenty = 20, hundren = 100
    }
    
    init (sides: DiceType) {
        _sides = sides
    }
    
}

// MARK: Functions
extension Dice {
    func roll() -> Int {
        Int.random(in: 1 ... sides.rawValue)
    }
    
    var sides: DiceType {
        get { _sides }
        set { _sides = newValue }
    }
}
