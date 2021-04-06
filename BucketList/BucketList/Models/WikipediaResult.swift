//
//  WikipediaResult.swift
//  BucketList
//
//  Created by Tino on 6/4/21.
//

import Foundation

struct WikipediaResult: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    enum CodingKeys: String, CodingKey {
        case pageID = "pageid"
        case title, terms
    }
    
    let pageID: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
}

extension Page: Comparable {
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.title == rhs.title
    }
}
