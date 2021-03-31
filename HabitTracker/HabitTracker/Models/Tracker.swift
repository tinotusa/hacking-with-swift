//
//  Tracker.swift
//  HabitTracker
//
//  Created by Tino on 31/3/21.
//

import Foundation

class Tracker: ObservableObject, Codable {
    static let trackerKey = "Tracker"
    @Published var habits = [Habit]() {
        didSet {
            save()
        }
    }

    init() { }
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }
    
    func removeHabit(offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    
    func save() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(habits) else {
            fatalError("Tracker: Failed to encode habits array")
        }
        UserDefaults.standard.setValue(data, forKey: Self.trackerKey)
    }
    
    // MARK: Codable conformance
    enum CodingKeys: CodingKey {
        case habits
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        habits = try container.decode([Habit].self, forKey: .habits)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(habits, forKey: .habits)
    }
}
