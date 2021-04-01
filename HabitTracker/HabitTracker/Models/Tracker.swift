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

    init() {
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: Self.trackerKey) else {
            return
        }
        guard let decodedHabits = try? decoder.decode([Habit].self, from: data) else {
            return
        }
        habits = decodedHabits
    }
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }
    
    func removeHabit(offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    
    func updateHabit(_ habit: Habit, by amount: Int) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else {
            fatalError("Tracker: ID mismatch")
        }
        habits[index].increment(by: amount)
    }
    
    func save() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(habits) else {
            fatalError("Tracker: Failed to encode habits array")
        }
        UserDefaults.standard.set(data, forKey: Self.trackerKey)
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
