//
//  AddBook.swift
//  Bookworm
//
//  Created by Tino on 1/4/21.
//

import SwiftUI

struct AddBook: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    static let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Other"]
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = Self.genres.first!
    @State private var rating: Int16 = 3
    @State private var review = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(Self.genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
                
                Section {
                    Rating(label: "Rating: ", rating: $rating)
                    TextField("Review", text: $review)
                }
                
                Section {
                    Button("Add book") {
                        addBook()
                    }
                }
            }
            .navigationBarTitle("Add book")
        }
    }
    
    func addBook() {
        let book = Book(context: moc)
        book.id = UUID()
        book.title = title
        book.author = author
        book.genre = genre
        
        book.rating = Int16(rating)
        book.review = review
        
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}
