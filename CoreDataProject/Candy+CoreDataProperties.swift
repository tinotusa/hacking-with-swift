//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Tino on 4/4/21.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    var wrappedName: String {
        name ?? "Unknown name"
    }
    
}

extension Candy : Identifiable {

}
