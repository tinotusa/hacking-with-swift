//
//  Mission.swift
//  Moonshot
//
//  Created by Tino on 23/4/21.
//

import SwiftUI

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewMember]
    let description: String
    
    struct CrewMember: Codable, Identifiable {
        enum CodingKeys: CodingKey {
            case name, role
        }
        let id = UUID()
        let name: String
        let role: String
    }
}

extension Mission {
    var name: String {
        "apollo\(id)"
    }
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var formattedLaunchDate: String {
        guard let launchDate = launchDate else {
            return "N/A"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: launchDate)
    }
}
