//
//  WikipediaResult.swift
//  BucketList
//
//  Created by Tino on 30/4/21.
//

import Foundation

struct WikipediaResult: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Identifiable {
    let pageid: Int
    let title: String
    let coordinates: [Coordinate]
    let thumbnail: Thumbnail?
    let terms: [String: [String]]?

    var thumbnailURL: String? {
        if let urlString = thumbnail?.source {
            return urlString
        }
        return nil
    }
    
    var description: String {
        if let desc = terms?["description"]?.first {
            return desc
        }
        return "No Further infomation"
    }
    var id: Int {
        pageid
    }
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}

struct Thumbnail: Codable {
    let source: String
    let width: Int
    let height: Int
}
