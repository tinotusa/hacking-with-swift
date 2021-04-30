//
//  PlacesContainer.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import Foundation

class PlacesContainer: ObservableObject, Codable {
    private(set) var places: [Place] = [] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    func add(_ place: Place) {
        places.append(place)
    }
    
    func remove(atOffsets offsets: IndexSet) {
        for offset in offsets {
            places.remove(at: offset)
        }
        print(places)
    }
    
    func move(offsets: IndexSet, newIndex: Int) {
        for offset in offsets {
            places.swapAt(offset, newIndex)
        }
    }
    
    // MARK: - Load and saving functionality
    enum CodingKeys: CodingKey {
        case places
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        places = try container.decode([Place].self, forKey: .places)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(places, forKey: .places)
    }
    
    static var saveURL = FileManager
        .default.urls(for: .documentDirectory, in: .userDomainMask).first!
        .appendingPathComponent("places.data")
    
    func load() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: Self.saveURL)
            places = try decoder.decode([Place].self, from: data)
            return
        } catch CocoaError.fileReadNoSuchFile {
            // do nothing
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(places)
            try data.write(to: Self.saveURL, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
}
