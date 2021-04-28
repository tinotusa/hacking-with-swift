//
//  BookDetail.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI
import CoreData

// couldn't figure out how to bind to a core data object
// made this struct i could bind to and passed that around instead
struct BookInfo {
    var imagePath = ""
    var title = ""
    var author = ""
    var genre: Genre = .fantasy
    var rating = Int16(0)
    var review = ""
    var id: UUID? = nil
    var isFavourite = false
}

struct BookDetail: View {
    let book: Book

    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.editMode) var editMode
    
    @EnvironmentObject var imageLoader: ImageLoader
    @State private var isAboutToDelete = false

    @State private var bookInfo = BookInfo()
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()

            if editMode?.wrappedValue == .active {
                BookEdit(book: book, bookInfo: $bookInfo)
                    .onAppear {
                        bookInfo = setBookInfo(from: book)
                    }
                    .onDisappear {
                        setBookData(from: bookInfo, to: book)
                    }
            } else {
                BookSummary(book: book)
            }
        }
        .alert(isPresented: $isAboutToDelete) {
            Alert(
                title: Text("About to delete \(book.wrappedTitle)?"),
                message: Text("Are you sure?"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Delete"), action: deleteBook)
            )
        }
        .toolbar {
            HStack {
                if editMode?.wrappedValue == .inactive {
                    Button(action: { isAboutToDelete = true }) {
                        Image(systemName: "trash")
                    }
                }
                if editMode?.wrappedValue == .active {
                    Button("Cancel") {
                        bookInfo = setBookInfo(from: book)
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                EditButton()
            }
        }
    }
    
    func setBookInfo(from book: Book) -> BookInfo {
        var bookInfo = BookInfo()
        bookInfo.imagePath =    book.wrappedImagePath
        bookInfo.title =        book.wrappedTitle
        bookInfo.author =       book.wrappedAuthor
        bookInfo.genre =        Genre(rawValue: book.wrappedGenre)!
        bookInfo.rating =       book.rating
        bookInfo.review =       book.wrappedReview
        bookInfo.id =           book.id
        bookInfo.isFavourite =  book.isFavourite
        return bookInfo
    }
    
    
    func setBookData(from bookInfo: BookInfo, to book: Book) {
        imageLoader.removePath(book.wrappedImagePath) // old one
        book.imagePath =    bookInfo.imagePath // write new one
        book.title =        bookInfo.title
        book.author =       bookInfo.author
        book.genre =        bookInfo.genre.rawValue
        book.rating =       bookInfo.rating
        book.review =       bookInfo.review
        book.id =           bookInfo.id
        book.isFavourite =  bookInfo.isFavourite
        Constants.saveContext(viewContext)
    }
    
    func deleteBook() {
        viewContext.delete(book)
        imageLoader.removePath(book.wrappedImagePath)
        Constants.saveContext(viewContext)
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct BookDetail_Previews: PreviewProvider {
    static let viewContext = PersistenceController.shared.container.viewContext
    
    static var previews: some View {
        let book = Book(context: viewContext)
        book.title = "test name"
        book.author = "an author"
        book.review = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam commodo urna vel eros iaculis dictum. Integer tempus orci sed enim vehicula, non porttitor elit fermentum. Vivamus in porta nisl, in sagittis nunc. Praesent ut purus sagittis, tristique diam vel, porta ipsum. Nulla eu augue quis arcu ultricies fringilla convallis ac ligula. Mauris quam urna, faucibus sed mauris in, iaculis gravida risus. Nullam quis turpis non risus tincidunt faucibus. Donec scelerisque efficitur leo, et pretium risus mattis ac. Fusce dictum eu lectus bibendum convallis. Nam aliquet, tellus eget sollicitudin euismod, magna erat consequat purus, sit amet rhoncus libero enim ac purus."
        
        return BookDetail(book: book)
            .environmentObject(ImageLoader())
            .environment(
                \.managedObjectContext,
                viewContext)
    }
}
