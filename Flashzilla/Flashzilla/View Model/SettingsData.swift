//
//  SettingsData.swift
//  Flashzilla
//
//  Created by Tino on 2/9/21.
//

import Foundation

final class SettingsData: ObservableObject {
    // model
    private(set) var settings = Settings()
    
    /// Default time limit in seconds.
    static var defaultTimeLimit = 60
    
    init() {
        load()
    }
    
    var mute: Bool {
        get { settings.mute }
        set { settings.mute = newValue }
    }
    
    var volume: Double {
        get { settings.volume }
        set {
            if newValue > 1 {
                settings.volume = 1
                return
            }
            settings.volume = newValue
        }
    }
    
    /// The time limit in seconds.
    var timeLimit: Int {
        get { settings.timeLimit }
        set {
            if newValue < 0 {
                return
            }
            settings.timeLimit = newValue
        }
    }
    
    var repeatQuestions: Bool {
        get { settings.repeatQuestions }
        set { settings.repeatQuestions = newValue }
    }
    
    var haptics: Bool {
        get { settings.shouldUseHaptics }
        set { settings.shouldUseHaptics = newValue }
    }
}

// MARK: - Loading and Saving
extension SettingsData {
    static let saveFilename = "settings.data"
    static let saveFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(saveFilename)
    func load() {
        do {
            let settingsData = try Data(contentsOf: Self.saveFileURL)
            settings = try JSONDecoder().decode(Settings.self, from: settingsData)
        } catch CocoaError.fileReadNoSuchFile {
            // do nothing
        } catch {
            print(error)
        }
    }
    
    func save() {
        do {
            let settingsData = try JSONEncoder().encode(settings)
            try settingsData.write(to: Self.saveFileURL, options: [.atomic, .completeFileProtection])
        } catch {
            print(error)
        }
    }
}
