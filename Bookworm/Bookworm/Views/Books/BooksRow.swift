//
//  BooksRow.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct BooksRow: View {
    let books: [Book]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(books) { book in
                    BookItem(book: book)
                }
            }
        }
    }
}
struct BooksRow_Previews: PreviewProvider {
    static let viewContext = PersistenceController.shared.container.viewContext
    static var previews: some View {
        let book = Book(context: viewContext)
        let books = [Book](repeating: book, count: 3)
        return BooksRow(books: books)
            .environmentObject(ImageLoader())
            .environment(
                \.managedObjectContext,
                viewContext)
    }
}
