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
    @State private var review = ""
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    ImageSelectionView(selectedImage: $selectedImage, imageURL: $selectedImageURL)
                        .floatView(to: .center)
                        
                    Divider()
                    
                    Group {
                        Text("Title")
                        TextField("Title", text: $title)
                    }
                    Group {
                        Text("Author")
                        TextField("Author", text: $author)
                    }
                    
                    RatingView("Rating", rating: $rating, showLabel: true)
                    Group {
                        Text("Genre")
                        Picker("Genre", selection: $genre) {
                            ForEach(Genre.allCases) { genre in
                                Text(genre.capitalized)
                            }
                        }
                    }

                    Text("Review")
                    
                    TextView("Enter a review of this book", text: $review)
                        .frame(minHeight: 300)
                }
                .padding()
            }
        }
        .foregroundColor(Color("fontColour"))
        .textFieldStyle(MyTextFieldStyle())
        .toolbar {
            Button("Add book", action: addBook)
                .disabled(!allFormsFilled)
        }
    }
    
    func addBook() {
        let book = Book(context: viewContext)
        book.title = title
        book.author = author
        book.rating = rating
        book.genre = genre.rawValue
        book.review = review
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
