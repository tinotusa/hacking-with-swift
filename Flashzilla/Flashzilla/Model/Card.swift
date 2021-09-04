//
//  Card.swift
//  Flashzilla
//
//  Created by Tino on 29/8/21.
//

import Foundation

struct Card {
    /// The unique id for this card.
    let id = UUID()
    /// The question on the flash card.
    let question: String
    /// The answer on the flash card.
    let answer: String
    
    // this is to silence the warning about id
    enum CodingKeys: CodingKey {
        case question, answer
    }
}

extension Card: Codable { }
extension Card: Identifiable { }
