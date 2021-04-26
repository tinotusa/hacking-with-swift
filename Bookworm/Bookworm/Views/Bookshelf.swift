//
//  Bookshelf.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct RatingView: View {
    let rating: Int16
    
    var body: some View {
        Text("\(rating) / 5")
    }
}

struct LikeButton: View {
    var isLiked: Bool
    
    var body: some View {
        Text("\(isLiked ? "Liked" : "Not liked")")
    }
}

struct FloatView: ViewModifier {
    let side: Side
    
    init(to side: Side = .topRight) {
        self.side = side
    }
    
    func body(content: Content) -> some View {
        VStack {
            if side == .bottomLeft || side == .bottomRight {
                Spacer()
            }
            HStack {
                if side == .topLeft {
                    content
                    Spacer()
                } else if side ==  .topRight {
                    Spacer()
                    content
                }
            }
            if side == .topLeft || side == .topRight {
                Spacer()
            }
        }
            
    }
    
    enum Side {
        case topLeft, topRight
        case bottomLeft, bottomRight
    }
}

extension View {
    func floatView(to side: FloatView.Side = .topRight) -> some View {
        modifier(FloatView(to: side))
    }
}

struct BookItem: View {
    let book: Book
    
    var body: some View {
        NavigationLink(destination: Text("book deatil view")) {
            ZStack(alignment: .bottom) {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 120, height: 160)
                        .cornerRadius(10)
                    if book.wrappedImagePath == "N/A" {
                        Text("No cover available")
                    } else {
                        loadImage(name: book.wrappedImagePath)
                    }
                }
                RatingView(rating: book.rating)
                LikeButton(isLiked: book.isFavourite)
                    .floatView(to: .topRight)
            }
            .padding(.vertical)
            .shadow(color: .gray, radius: 5, x: 0, y: 3)
        }
        
    }
    
    func loadImage(name: String) -> Image {
        Image("default")
    }
}

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

struct Bookshelf: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: [])
    var books: FetchedResults<Book>
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
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
            .foregroundColor(Color("fontColor"))
            .toolbar {
                Button("add books", action: addBook)
                    .buttonStyle(DefaultButtonStyle())
            }
        }
    }
    
    func addBook() {
        let genres = ["fantasy", "fiction", "scifi", "children"]
        let genre = genres.randomElement()!
        let _ = createBook(
            title: "a title",
            author: "a author",
            genre: genre,
            rating: 3
        )
    }
    
    func deleteBooks(atOffsets offsets: IndexSet) {
        offsets.map { books[$0] }
            .forEach(viewContext.delete)
        saveContext()
    }
    
    func createBook(title: String, author: String, genre: String, rating: Int16) -> Book {
        let newBook = Book(context: viewContext)
        newBook.title = title
        newBook.author = author
        newBook.rating = rating
        newBook.genre = genre
        saveContext()
        return newBook
    }
}

enum Genre: String, Identifiable, Comparable {
    case fantasy, fiction, children, scifi, horror, romance
    static func <(lhs: Genre, rhs: Genre) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    var id: Genre { self }
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
            .environment(
                \.managedObjectContext,
                PersistenceController.shared.container.viewContext)
    }
}
