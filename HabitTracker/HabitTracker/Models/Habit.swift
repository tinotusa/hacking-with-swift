//
//  Habit.swift
//  HabitTracker
//
//  Created by Tino on 31/3/21.
//

import Foundation


struct Habit: Codable, Identifiable {
    let id = UUID()
    
    var name: String
    var timesCompleted: Int
    var description = ""
    var timeCompleted = Date()
    
    var shortDescription: String {
        if description.isEmpty {
            return "N/A"
        } else if description.count > 30 {
            return String(Array(description)[0...30]) + "..."
        }
        return description
    }
}
