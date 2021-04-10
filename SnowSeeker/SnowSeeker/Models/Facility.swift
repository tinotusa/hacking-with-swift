//
//  Facility.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import Foundation
import SwiftUI

struct Facility {
    let id = UUID()
    let facilityName: String
}

extension Facility: Identifiable { }

// MARK: - Static properties
extension Facility {
    static let icons = [
        "Family":           "person.3",
        "Cross-country":    "map",
        "Accommodation":    "house",
        "Eco-friendly":     "leaf.arrow.circlepath",
        "Beginners":        "1.circle",
    ]
    
    static let messages = [
        "Family":           "This resort is popular with families.",
        "Cross-country":    "This resort has many cross-country ski routes.",
        "Accommodation":    "This resort has popular on-site accommodation.",
        "Eco-friendly":     "This resort has won an award for environmental friendliness.",
        "Beginners":        "This resort has a lot of ski schools.",
    ]
}

// MARK: - Functions
extension Facility {
    var icon: some View {
        guard let iconName = Self.icons[facilityName] else {
            fatalError("Unknown facility name \(facilityName)")
        }
        return Image(systemName: iconName)
            .accessibility(label: Text(facilityName))
            .foregroundColor(.secondary)
    }
    
    var alert: Alert {
        guard let message = Self.messages[facilityName] else {
            fatalError("Unknown facility name \(facilityName)")
        }
        return Alert(title: Text(facilityName), message: Text(message))
    }
}
