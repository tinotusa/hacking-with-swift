//
//  Genre.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

enum Genre: String, Identifiable, Comparable, CaseIterable {
    case fantasy, fiction, children, scifi, horror, romance
    
    static func <(lhs: Genre, rhs: Genre) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
  
    var id: Genre { self }
}
