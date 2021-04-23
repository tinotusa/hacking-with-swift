//
//  Constants.swift
//  Moonshot
//
//  Created by Tino on 23/4/21.
//

import SwiftUI

struct Constants {
    static let missions: [Mission] = load("missions.json")
    static let astronauts: [Astronaut] = load("astronauts.json")

    static var background: some View {
        Color("darkGray")
    }
}

fileprivate func load<T: Decodable>(_ filename: String) -> T {
    guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("\(filename) not found in bundle")
    }
    
    let decoder = JSONDecoder()
    let dateFormetter = DateFormatter()
    dateFormetter.dateFormat = "yyyy-MM-dd"
    decoder.dateDecodingStrategy = .formatted(dateFormetter)
    
    do {
        let data = try Data(contentsOf: url)
        return try decoder.decode(T.self, from: data)
    } catch {
        print(error.localizedDescription)
    }
    fatalError("Failed to decode data from url")
}
