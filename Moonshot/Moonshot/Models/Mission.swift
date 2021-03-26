//
//  Mission.swift
//  Moonshot
//
//  Created by Tino on 25/3/21.
//

import Foundation

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    var imageName: String {
        "apollo\(id)"
    }
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var formattedLaunchDate: String {
        if launchDate == nil {
            return "N/A"
        }
        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateStyle = .long
        return formatter.string(from: launchDate!)
    }
}
