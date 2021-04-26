//
//  ContentView.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: [])
    var books: FetchedResults<Book>
    
    var body: some View {
        VStack {
            HStack {
                Button("Add book") {
                    let newBook = Book(context: viewContext)
                    newBook.title = "some title"
                    newBook.author = "some author"
                    saveContext()
                }
                
                Button("delete book") {
                    if !books.isEmpty {
                        viewContext.delete(books.first!)
                        saveContext()
                    }
                }
            }
            List(books) { book in
                Text(book.wrappedTitle)
                Text(book.wrappedAuthor)
            }
        }
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try withAnimation {
                    try viewContext.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(
                \.managedObjectContext,
                PersistenceController.shared.container.viewContext
            )
    }
}
