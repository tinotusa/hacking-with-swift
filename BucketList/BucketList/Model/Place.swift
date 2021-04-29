//
//  Place.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import CoreLocation

struct Place: Codable, Identifiable {
    let id = UUID()
    var name: String
    var coordinates: CLLocationCoordinate2D

    init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
    }
    
    enum CodingKeys: CodingKey  {
        case name, longitude, latitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        coordinates = CLLocationCoordinate2D()
        coordinates.latitude = latitude
        coordinates.longitude = longitude
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    static var example: Place {
        Place(
            name: "Rome",
            coordinates: CLLocationCoordinate2D(latitude: -1, longitude: 0)
        )
    }
}
