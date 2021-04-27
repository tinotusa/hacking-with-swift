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
    
    @EnvironmentObject var imageLoader: ImageLoader
    
    @State private var showingAddView = false
    @State private var showingDeleteList = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                
                NavigationLink(destination: AddBookView(), isActive: $showingAddView) { EmptyView() }
                
                if showingDeleteList {
                    bookListView
                } else {
                    bookRowView
                }
            }
            .navigationTitle("Bookshelf")
            .foregroundColor(Color("fontColour"))
            .toolbar {   
                HStack {
                    if !showingDeleteList {
                        Button(action: { showingAddView = true }) {
                            Image(systemName: "plus")
                                .font(.title)
                        }
                    }

                    Button(action: deleteBooks) {
                        if showingDeleteList {
                            Text("Done")
                        } else {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
    }
    
    
    func deleteFromGenres(atOffsets offsets: IndexSet, genre: Genre) {
        for offset in offsets {
            let book = genres[genre]![offset]
            imageLoader.removePath(book.wrappedImagePath)
            viewContext.delete(book)
            Constants.saveContext(viewContext)
        }
    }
    
    func deleteBooks() {
        showingDeleteList.toggle()
    }
}

private extension Bookshelf {
    var bookListView: some View {
        List {
            ForEach(genres.keys.sorted(), id: \.self) { genre in
                Text(genre.rawValue.capitalized)
                    .font(.title)
                ForEach(genres[genre]!) { book in
                    HStack {
                        imageLoader.loadImage(path: book.wrappedImagePath)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        VStack(alignment: .leading) {
                            Text(book.wrappedTitle)
                            Text(book.wrappedAuthor)
                        }
                    }
                }
                .onDelete { offsets in
                    deleteFromGenres(atOffsets: offsets, genre: genre)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    var bookRowView: some View {
        ScrollView(showsIndicators: false) {
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
