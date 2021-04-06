//
//  User+CoreDataProperties.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 6/4/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var friends: Data?
    @NSManaged public var tags: Data?

    var initials: String {
        wrappedName
            .split(separator: " ")
            .map { String($0.first!).capitalized }
            .joined(separator: "")
    }
    
    static var testUser: User {
        let newUser = User(context: PersistenceController.shared.container.viewContext)
        
        newUser.id = UUID(uuidString:"50a48fa3-2c0f-4397-ac50-64da464f9954")!
        newUser.isActive = false
        newUser.name = "test name"
        newUser.age = 23
        newUser.company = "a company"
        newUser.email = "email@server.com"
        newUser.address = "soem add ress"
        newUser.about = "a short about page"
        newUser.registered = Date()
        newUser.tags = try! JSONEncoder().encode(["some","tag"])
        newUser.friends = try! JSONEncoder().encode(
            [
                FriendStruct(id: UUID(), name: "some friend name")
            ]
        )
        return newUser
    }
}

// MARK: wrapped optionals
extension User {
    var wrappedAbout: String {
        about ?? "Unknown value"
    }
    var wrappedAddress: String {
        address ?? "Unknown value"
    }
    var wrappedCompany: String {
        company ?? "Unknown value"
    }
    var wrappedEmail: String {
        email ?? "Unknown value"
    }
    var wrappedName: String {
        name ?? "Unknown value"
    }
    var wrappedRegistered: Date {
        registered ?? Date()
    }
    var wrappedFriends: [FriendStruct] {
        let decoder = JSONDecoder()
        
        var decodedData = [FriendStruct]()
        
        guard let data = friends else { return decodedData }
        
        do {
            decodedData = try decoder.decode([FriendStruct].self, from: data)
        } catch {
            print("unresolved error \(error), \(error.localizedDescription)")
        }
        return decodedData
    }
    
    var wrappedTags: [String] {
        var decodedData = [String]()
        
        guard let data = tags else { return decodedData }
        
        let decoder = JSONDecoder()
        
        do {
            decodedData = try decoder.decode([String].self, from: data)
        } catch {
            print("unresolved error \(error.localizedDescription)")
        }
        
        return decodedData
    }
}

// MARK: helpers
extension User {
    var shortAbout: String {
        guard let about = about else { return "N/A" }
        if about.count > 100 {
            return  String(Array(about)[...100]) + "..."
        }
        return about
    }
    
    var formattedRegistedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: wrappedRegistered)
    }
}

extension User : Identifiable {

}
