//
//  MKPointAnnotation-Codable.swift
//  BucketList
//
//  Created by Tino on 6/4/21.
//

import MapKit

class CodableMKPointAnnotation: MKPointAnnotation, Codable {
    override init() {
        super.init()
    }
 
    // MARK: Codable conformance
    enum CodingKeys: CodingKey {
        case title, subtitle, latitude, longitude
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            title = try container.decode(String.self, forKey: .title)
            subtitle = try container.decode(String.self, forKey: .subtitle)
            let latitude = try container.decode(Double.self, forKey: .latitude)
            let longitude = try container.decode(Double.self, forKey: .longitude)
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
        } catch {
            print(error)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
}
