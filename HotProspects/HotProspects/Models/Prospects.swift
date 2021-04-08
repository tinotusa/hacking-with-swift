//
//  Prospects.swift
//  HotProspects
//
//  Created by Tino on 7/4/21.
//

import Foundation

class Prospects: ObservableObject {
    @Published fileprivate(set) var people: [Prospect]
    static let saveFile = "SavedData"
    init() {
        let decoder = JSONDecoder()
        do {
            let saveURL = FileManager.default.documentsURL().appendingPathComponent(Self.saveFile)
            let data = try Data(contentsOf: saveURL)
            people = try decoder.decode([Prospect].self, from: data)
            return
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        people = []
    }
}


// MARK: Functions
extension Prospects {
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func delete(atOffsets offsets: IndexSet) {
        people.remove(atOffsets: offsets)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        let saveURL = FileManager.default.documentsURL().appendingPathComponent(Self.saveFile)
        do {
            let data = try encoder.encode(people)
            try data.write(to: saveURL, options: .atomicWrite)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func filter(_ predicate: (Prospect) -> Bool) -> [Prospect] {
        return people.filter(predicate)
    }
    
    func toggle(_ person: Prospect) {
        objectWillChange.send()
        person.toggleContacted()
        save()
    }
    
    func sorted(by: (Prospect, Prospect) -> Bool) -> [Prospect] {
        []
    }
}
