//
//  Friend+CoreDataProperties.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 6/4/21.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

    var wrappedName: String {
        name ?? "Unknown value"
    }
}

extension Friend : Identifiable {

}
