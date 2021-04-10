//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

class Favourites {
    private var _resorts: Set<String>
    private static var saveKey = "FavouritesSave"
    private static var saveURL = FileManager.default.documentsURL().appendingPathComponent(saveKey)
    
    init() {
        _resorts = []
        load()
        
    }
}

extension Favourites: ObservableObject { }

// MARK: - Functions
extension Favourites {
    var resorts: Set<String> {
        _resorts
    }
    
    func contains(_ resort: Resort) -> Bool {
        _resorts.contains(resort.id)
    }
    
    func update(_ resort: Resort) {
        if contains(resort) {
            remove(resort)
        } else {
            add(resort)
        }
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        _resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        _resorts.remove(resort.id)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(_resorts)
            try data.write(to: Self.saveURL)
        } catch {
            print("Unresolved error \(error)")
        }
    }
    
    func load() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: Self.saveURL)
            _resorts = try decoder.decode(Set<String>.self, from: data)
        } catch {
            print(error)
        }
    }
}
