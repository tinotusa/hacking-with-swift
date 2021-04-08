//
//  Prospect.swift
//  HotProspects
//
//  Created by Tino on 7/4/21.
//

import SwiftUI

class Prospect: Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    init() {
        
    }
    
    init(name: String, emailAddress: String) {
        self.name = name
        self.emailAddress = emailAddress
    }
    
    // MARK: Codable conformance
    enum CodingKeys: CodingKey {
        case name, emailAddress, isContacted
    }
    
    func toggleContacted() {
        isContacted.toggle()
    }
}

extension Prospect: Identifiable { }


