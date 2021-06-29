//
//  PersonalDetails.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import Foundation

struct PersonalDetails: Codable {
    var name = "" {
        didSet {
            save()
        }
    }
    var email = "" {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    static let saveFilename = "userDetails"
    
    func save() {
        let saveURL = FileManager.documentDirectory.appendingPathComponent(Self.saveFilename)
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: saveURL, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    mutating func load() {
        let saveURL = FileManager.documentDirectory.appendingPathComponent(Self.saveFilename)
        do {
            let data = try Data(contentsOf: saveURL)
            self = try JSONDecoder().decode(PersonalDetails.self, from: data)
        } catch {
            print(error)
        }
    }
    
    var combindedDetails: String {
        "\(name)\n\(email)"
    }
    
    var validDetails: Bool {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        return !name.isEmpty && !email.isEmpty
    }
}
