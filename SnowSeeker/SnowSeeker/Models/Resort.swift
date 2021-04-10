//
//  Resort.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import Foundation

struct Resort: Codable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
}

extension Resort: Identifiable { }

// MARK: - Static fields
extension Resort {
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts.first!
}

// MARK: - Functions
extension Resort {
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}
