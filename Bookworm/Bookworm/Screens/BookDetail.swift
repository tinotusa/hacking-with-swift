//
//  BookDetail.swift
//  Bookworm
//
//  Created by Tino on 1/4/21.
//

import SwiftUI
import CoreData


struct BookDetail: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        VStack {
            LabeledImage(label: book.genre ?? "Fantasy")
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(formattedDate)
            
            Text(book.review ?? "No review")
                .padding()
            
            Rating(label: "", rating: .constant(book.rating))
                .font(.largeTitle)
            Spacer()
        }
        .navigationBarTitle(Text(book.title ?? "Unknown book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { showingDeleteAlert = true }) {
            Image(systemName: "trash")
        })
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"),
                  message: Text("Are you sure you want to delete this book"),
                  primaryButton: .destructive(Text("Delete")) { deleteBook(book) },
                  secondaryButton: .cancel()
            )
        }
    }
    
    private func deleteBook(_ book: Book) {
        moc.delete(book)
        try? moc.save()

        presentationMode.wrappedValue.dismiss()
    }
    
    private var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: book.date ?? Date())
    }
}

struct BookDetail_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.id = UUID()
        book.title = "The Hobbit"
        book.author = "J. R. R. Tolkien"
        book.rating = 4
        book.review = "yeah, pretty good ay"
        book.date = Date()
        
        return BookDetail(book: book)
    }
}
