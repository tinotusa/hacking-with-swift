//
//  User.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 4/4/21.
//

import Foundation

struct UserStruct: Codable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [FriendStruct]
    
    static var testUser: UserStruct {
        UserStruct(id: UUID(uuidString: "50a48fa3-2c0f-4397-ac50-64da464f9954")!,
             isActive: false,
             name: "test name",
             age: 23,
             company: "a company",
             email: "email@server.com",
             address: "soem add ress",
             about: "a short about page",
             registered: Date(),
             tags: ["some", "tag"],
             friends: [
                FriendStruct(id: UUID(), name: "some friend name")
             ])
    }
    
    var initials: String {
        name
            .split(separator: " ")
            .map { String($0.first!).capitalized }
            .joined(separator: "")
    }
    
    var formattedRegistedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: registered)
    }
    
    var shortAbout: String {
        if about.count > 100 {
            return  String(Array(about)[...100]) + "..."
        }
        return about
    }
}
