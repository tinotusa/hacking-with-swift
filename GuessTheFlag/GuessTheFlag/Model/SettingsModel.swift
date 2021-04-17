//
//  SettingsModel.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import Foundation

extension FileManager {
    func documentsURL() -> URL {
        let paths = Self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
}

class SettingsModel: ObservableObject, Codable {
    static let saveURL = FileManager.default.documentsURL().appendingPathComponent("Settings Save")
    @Published var shouldRepeatQuestions = false
    @Published var numberOfQuestions = 10
    
    init() {
        load()
    }
    
    enum CodingKeys: CodingKey {
        case shouldRepeatQuestions
        case numberOfQuestions
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            shouldRepeatQuestions = try container.decode(Bool.self, forKey: .shouldRepeatQuestions)
            numberOfQuestions = try container.decode(Int.self, forKey: .numberOfQuestions)
            return
        } catch {
            print("Failed to decode Settings model\n\(error)")
        }
        shouldRepeatQuestions = false
        numberOfQuestions = 10
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(shouldRepeatQuestions, forKey: .shouldRepeatQuestions)
            try container.encode(numberOfQuestions, forKey: .numberOfQuestions)
        } catch {
            print("failed to encode SettingsModel\n\(error)")
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            try data.write(to: Self.saveURL)
        } catch {
            print("Failed to save SettingsModel\n\(error)")
        }
    }
    
    func load() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: Self.saveURL)
            let settings = try decoder.decode(SettingsModel.self, from: data)
            self.shouldRepeatQuestions = settings.shouldRepeatQuestions
            self.numberOfQuestions = settings.numberOfQuestions
            return
        } catch {
            print("Failed to load settings\n\(error)")
        }
        shouldRepeatQuestions = false
        numberOfQuestions = 10
    }
}
