//
//  Book+CoreDataProperties.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var genre: String?
    @NSManaged public var rating: Int16
    @NSManaged public var isbn: String?
    @NSManaged public var review: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var imagePath: String?

    var wrappedTitle: String {
        title ?? "N/A"
    }
    
    var wrappedAuthor: String {
        author ?? "N/A"
    }
    
    var wrappedGenre: String {
        genre ?? "N/A"
    }
    
    var wrappedISBN: String {
        isbn ?? "N/A"
    }
    
    var wrappedImagePath: String {
        imagePath ?? "N/A"
    }
    
}

extension Book : Identifiable {

}
