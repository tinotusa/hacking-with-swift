//
//  Card.swift
//  Flashzilla
//
//  Created by Tino on 29/8/21.
//

import Foundation

struct Card: Codable, Identifiable {
    let id = UUID()
    
    enum CodingKeys: CodingKey {
        case question, answer
    }
    let question: String
    let answer: String
}
