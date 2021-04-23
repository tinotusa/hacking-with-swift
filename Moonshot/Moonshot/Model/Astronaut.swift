//
//  Astronaut.swift
//  Moonshot
//
//  Created by Tino on 23/4/21.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    
    var birthday: String {
        let range = NSRange(location: 0, length: description.utf16.count)
        let regex = try! NSRegularExpression(pattern: "\\w+ \\d{1,2}, \\d{4}")
        let results = regex.matches(in: description, options: [], range: range)
        let matches = results.map {
            String(
                description[Range($0.range, in: description)!]
            )
        }
        if matches.count >= 2 {
            return "\(matches[0]) - \(matches[1])"
        }
        return matches[0]
    }
}
