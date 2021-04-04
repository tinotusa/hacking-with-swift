//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Tino on 2/4/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

    var wrappedTitle: String {
        title ?? "Unknown title"
    }
    
    var wrappedDirector: String {
        director ?? "Unknown director"
    }
}

extension Movie : Identifiable {

}
