//
//  BookDetail.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI
import CoreData

struct BookInfo {
    var imagePath = ""
    var title = ""
    var author = ""
    var genre: Genre = .fantasy
    var rating = Int16(0)
    var review = ""
}
struct BookDetail: View {
    let book: Book

    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.editMode) var editMode
    
    @EnvironmentObject var imageLoader: ImageLoader
    @State private var isAboutToDelete = false

    @State private var bookInfo = BookInfo()
    @State private var copyBookInfo = BookInfo()
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            if editMode?.wrappedValue == .active {
                BookEdit(book: book, bookInfo: $copyBookInfo)
                    .onAppear {
                        setBookInfo(book, info: copyBookInfo)
                    }
                    .onDisappear {
                        setBookData(book, info: copyBookInfo)
                    }
            } else {
                BookSummary(book: book)
            }
        }
        .alert(isPresented: $isAboutToDelete) {
            Alert(
                title: Text("Delete"),
                message: Text("Are you sure?"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Delete"), action: deleteBook)
            )
        }
        .toolbar {
            HStack {
                Button("Delete", action: deleteBook)
                if editMode?.wrappedValue == .active {
                    Button("Cancel") {
                        // no changes have been made
                        // no save required
                        
                        // store prev state
                        setBookData(book, info: bookInfo)
                        Constants.saveContext(viewContext)
                        // restore on cancel
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                EditButton()
                
            }
        }
        .onAppear {
            setBookInfo(book, info: bookInfo)
        }
    }
    
    func setBookInfo(_ book: Book, info: BookInfo) {
        bookInfo.imagePath =    book.wrappedImagePath
        bookInfo.title =        book.wrappedTitle
        bookInfo.author =       book.wrappedAuthor
        bookInfo.genre =        Genre(rawValue: book.wrappedGenre)!
        bookInfo.rating =       book.rating
        bookInfo.review =       book.wrappedReview
    }
    
    func setBookData(_ book: Book, info: BookInfo) {
        book.imagePath =    bookInfo.imagePath
        book.title =        bookInfo.title
        book.author =       bookInfo.author
        book.genre =        bookInfo.genre.rawValue
        book.rating =       bookInfo.rating
        book.review =       bookInfo.review

        Constants.saveContext(viewContext)
    }
    
    func deleteBook() {
        viewContext.delete(book)
        imageLoader.removePath(book.wrappedImagePath)
        saveContext(context: viewContext)
        dismiss()
    }
    
    func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try withAnimation {
                    try context.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
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
