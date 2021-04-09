//
//  Card.swift
//  Flashzilla
//
//  Created by Tino on 8/4/21.
//

import Foundation

struct Card: Codable {
    var id = UUID()
    let prompt: String
    let answer: String
}

extension Card: Identifiable { }

extension Card: CustomStringConvertible {
    var description: String {
        "\(prompt) \(answer)\n"
    }
}

extension Card {
    static var example = Card(prompt: "What is the capital of Australia?", answer: "Canberra")
}

