//
//  Prospect.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import Foundation

struct Prospect: Equatable, Codable, Identifiable, CustomStringConvertible {
    let id = UUID()
    let name: String
    let email: String
    var isContacted = false
    
    init (name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    mutating func contact() {
        isContacted.toggle()
    }
    
    enum CodingKeys: CodingKey {
        case name, email, isContacted
    }
    
    // Equatable conformance
    static func ==(lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name == rhs.name && lhs.email == rhs.email
    }
    
    // CustomStringConvertible conformance
    var description: String {
        "name: \(name), email: \(email), isContacted: \(isContacted)"
    }
}
