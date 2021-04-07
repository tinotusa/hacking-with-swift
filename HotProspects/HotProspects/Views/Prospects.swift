//
//  Prospects.swift
//  HotProspects
//
//  Created by Tino on 7/4/21.
//

import Foundation

class Prospects: ObservableObject {
    @Published fileprivate(set) var people: [Prospect]
    static let saveKey = "SavedData"
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
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
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func filter(_ predicate: (Prospect) -> Bool) -> [Prospect] {
        return people.filter(predicate)
    }
    
    func toggle(_ person: Prospect) {
        objectWillChange.send()
        person.toggle()
        save()
    }
}
