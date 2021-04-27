//
//  Bookshelf.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct Bookshelf: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: [])
    var books: FetchedResults<Book>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                
                NavigationLink(destination: AddBookView(), isActive: $showingAddView) { EmptyView() }
                
                ScrollView {
                    ForEach(genres.keys.sorted(), id: \.self) { genre in
                        VStack(alignment: .leading) {
                            Text(genre.rawValue.capitalized)
                                .font(.title)
                                .padding(.horizontal)
                                Divider()
                            BooksRow(books: genres[genre]!)
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Bookshelf")
            .foregroundColor(Color("fontColour"))
            .toolbar {   
                HStack {
                    Button(action: { showingAddView = true }) {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                    // see if you can create a menut t
                    Button("delete all") {
                        books.forEach(viewContext.delete)
                        saveContext()
                    }
                }
            }
        }
    }
    
    // MARK: - testing functions
    func deleteBooks(atOffsets offsets: IndexSet) {
        offsets.map { books[$0] }
            .forEach(viewContext.delete)
        saveContext()
    }
}

private extension Bookshelf {
    var genres: [Genre: [Book]] {
        let dict: [Genre: [Book]] = Dictionary(grouping: books) {
            return Genre(rawValue: $0.wrappedGenre)!
        }
        return dict
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

struct Bookshelf_Previews: PreviewProvider {
    static var previews: some View {
        Bookshelf()
            .environmentObject(ImageLoader())
            .environment(
                \.managedObjectContext,
                PersistenceController.shared.container.viewContext)
    }
}
