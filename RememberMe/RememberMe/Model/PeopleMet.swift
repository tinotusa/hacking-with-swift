//
//  PeopleMet.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import Foundation

class PeopleMet: ObservableObject, Codable {
    @Published var people: [Person] = []
    
    init() {
        load()
    }
    
    // MARK: Codable conformance
    enum CodingKeys: CodingKey {
        case people
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        people = try container.decode([Person].self, forKey: .people)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(people, forKey: .people)
    }
}

// MARK: Functions
extension PeopleMet {
    static let saveFile = "savedPeople"
    
    func add(_ person: Person) {
        people.append(person)
        save()
    }
    
    func delete(atOffsets offsets: IndexSet) {
        people.remove(atOffsets: offsets)
        save()
    }
    
    func edit(_ person: Person, name: String, description: String) {
        var person = person
        person.name = name
        person.description = description
        let index = people.firstIndex(where: { $0.id == person.id })!
        people[index] = person
        save()
    }
    
    func load() {
        let decoder = JSONDecoder()
        do {
            let saveFileURL = FileManager.default.documentsURL().appendingPathComponent(Self.saveFile)
            let data = try Data(contentsOf: saveFileURL)
            people = try decoder.decode([Person].self, from: data)
            print("has data")
            people.sort()
        } catch(let error as DecodingError) {
            print("Unresoved error: \(error)")
        } catch {
            print("Unresoved error: \(error.localizedDescription)")
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(people)
            let saveURL = FileManager.default.documentsURL().appendingPathComponent(Self.saveFile)
            try data.write(to: saveURL, options: .atomicWrite)
        } catch {
            print("Unresolved error: \(error.localizedDescription)")
        }
    }
}
