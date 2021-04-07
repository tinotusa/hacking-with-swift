//
//  Person.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import Foundation
import SwiftUI
import MapKit

struct Person: Codable {
    var name: String
    var imagePath: String
    var description: String
    var locationWhenAdded: CLLocationCoordinate2D
    
    let id = UUID()
    let dateMet = Date()
    
    init(name: String) {
        self.name = name
        self.imagePath = id.uuidString
        description = ""
        locationWhenAdded = CLLocationCoordinate2D(latitude: 51.50722, longitude: -0.1275)
    }

    init(name: String, description: String) {
        self.init(name: name)
        self.description = description
    }

    // MARK: Codable conformance
    enum CodingKeys: CodingKey {
        case name, imagePath, description, latitude, longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        imagePath = try container.decode(String.self, forKey: .imagePath)
        description = try container.decode(String.self, forKey: .description)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        locationWhenAdded = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(imagePath, forKey: .imagePath)
        try container.encode(description, forKey: .description)
        try container.encode(locationWhenAdded.latitude, forKey: .latitude)
        try container.encode(locationWhenAdded.longitude, forKey: .longitude)
    }
}

extension Person: Identifiable { }

// MARK: Functions and computed properties
extension Person {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: dateMet)
    }
    
    /// Returns the image at the person's imagePath or a default image
    /// ```
    /// somePerson.getImage() // returns an image
    /// ```
    /// - warning: The returned image is a default image if an image at the imagePath wasn't found
    /// - returns: An image found at the person imagePath
    func getImage() -> Image {
        let defaultImage = Image("default")
        
        let imageURL = FileManager.default.documentsURL().appendingPathComponent(imagePath)
        do {
            let imageData = try Data(contentsOf: imageURL)
            guard let uiImage = UIImage(data: imageData) else {
                return defaultImage
            }
            return Image(uiImage: uiImage)
        } catch {
            print("Unresolved error \(error.localizedDescription)")
        }

        return defaultImage
    }
}

// MARK: Comparable conformace
extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}
