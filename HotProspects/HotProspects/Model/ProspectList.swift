//
//  ProspectList.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import Foundation

class ProspectList: ObservableObject, Codable {
    @Published var prospects: [Prospect] = [] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    func add(_ prospect: Prospect) {
        prospects.append(prospect)
    }
    
    func remove(_ prospect: Prospect) {
        guard let index = prospects.firstIndex(where: { $0.id == prospect.id }) else {
            fatalError("Tried to remove non existant prospect \(prospect)")
        }
        prospects.remove(at: index)
    }
    
    func remove(offsets: IndexSet) {
        prospects.remove(atOffsets: offsets)
    }
    
    func contact(index: Int) {
        prospects[index].contact()
    }
    
    subscript(_ index: Int) -> Prospect {
        prospects[index]
    }
    
    // MARK: -- Codable conformance --
    
    enum CodingKeys: CodingKey {
        case prospects
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let prospects = try container.decode([Prospect].self, forKey: .prospects)
            self.prospects = prospects
        } catch {
            print(error)
        }
    }
    
    func encode(to encoder: Encoder) {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(prospects, forKey: .prospects)
        } catch {
            print(error)
        }
    }
    
    static let saveFilename = "prospects"
    
    func save() {
        let saveURL = FileManager.documentDirectory.appendingPathComponent(Self.saveFilename)
        
        do {
            let data = try JSONEncoder().encode(prospects)
            try data.write(to: saveURL, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    func load() {
        let saveURL = FileManager.documentDirectory.appendingPathComponent(Self.saveFilename)
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: saveURL)
            prospects = try decoder.decode([Prospect].self, from: data)
        } catch {
            prospects = []
            print(error)
        }
    }
}

extension FileManager {
    static var documentDirectory: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
