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
        get { title ?? "N/A" }
        set { title = newValue }
    }
    
    var wrappedAuthor: String {
        get { author ?? "N/A" }
        set { author = newValue }
    }
    
    var wrappedGenre: String {
        get { genre ?? "N/A" }
        set { genre = newValue }
    }
    
    var wrappedISBN: String {
        isbn ?? "N/A"
    }
    
    var wrappedImagePath: String {
        get { imagePath ?? "N/A" }
        set { imagePath = newValue }
    }
    
    var wrappedReview:  String {
        get { review ?? "N/A" }
        set { review = newValue }
    }
    
}

extension Book : Identifiable {

}
