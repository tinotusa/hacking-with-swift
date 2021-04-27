//
//  AddBookView.swift
//  Bookworm
//
//  Created by Tino on 27/4/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var image: Image?
    @State private var selectedImage: UIImage?
    @State private var selectedImageURL: URL?
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating: Int16 = 0
    @State private var genre: Genre = .fantasy
    
    var body: some View {
        VStack {
            ImageSelectionView(selectedImage: $selectedImage, imageURL: $selectedImageURL)
            Divider()
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                }
                
                Section {
                    RatingView("Rating", rating: $rating)
                    Picker("genre", selection: $genre) {
                        ForEach(Genre.allCases) { genre in
                            Text(genre.rawValue.capitalized)
                        }
                    }
                }
                Section {
                    Button("Add book", action: addBook)
                        .disabled(!allFormsFilled)
                }
            }
        }
        .padding()
    }
    
    func addBook() {
        let book = Book(context: viewContext)
        book.title = title
        book.author = author
        book.rating = rating
        book.genre = genre.rawValue
        book.imagePath = selectedImageURL?.lastPathComponent
        book.id = UUID()
        Constants.saveContext(viewContext)
        presentationMode.wrappedValue.dismiss()
    }
    
    var allFormsFilled: Bool {
        let title = trimSpace(self.title)
        let author = trimSpace(self.author)
        return !title.isEmpty && !author.isEmpty
    }
    
    private func trimSpace(_ text: String) -> String {
        text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
