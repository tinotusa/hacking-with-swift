//
//  BookRow.swift
//  Bookworm
//
//  Created by Tino on 1/4/21.
//

import SwiftUI
import CoreData

struct BookRow: View {
    let book: Book

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.title ?? "Unknown title")
                    .font(.headline)
                    .foregroundColor(color(for: book.rating))
                Text(book.author ?? "Unknown author")
                    .foregroundColor(.secondary)
            }
            Spacer()
            EmojiRating(rating: book.rating)
                .font(.largeTitle)
        }
    }
    
    private func color(for rating: Int16) -> Color {
        if rating == 1 {
            return .red
        }
        return .black
    }
}

struct BookRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        
        book.id = UUID()
        book.title = "test name"
        book.author = "test author"
        book.rating = 1
        book.review = ""
        book.genre = "Fantasy"
        book.date = Date()
        
        return BookRow(book: book)
    }
}
