//
//  BookItem.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct BookItem: View {
    let book: Book
    let radius: CGFloat = 10
    
    @EnvironmentObject var imageLoader: ImageLoader
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationLink(destination: BookDetail(book: book)) {
            ZStack(alignment: .bottom) {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: Constants.bookWidth, height: Constants.bookHeight)
                        .cornerRadius(radius)
                    imageLoader.loadImage(path: book.wrappedImagePath)
                        .resizable()
                        .frame(width: Constants.bookWidth, height: Constants.bookHeight)
                }
                RatingView(rating: .constant(book.rating))
                    .font(.subheadline)
                    .shadow(radius: 10)
                if book.isFavourite {
                    LikeButton(isLiked: .constant(book.isFavourite))
                        .floatView(to: .topRight)
                }
            }
            .padding(.vertical)
            .shadow(color: (colorScheme == .dark ? Color.black.opacity(0.4) : Color.gray), radius: 5, x: 0, y: 3)
        }
        .foregroundColor(Color("fontColour"))
    }
}

struct BookItem_Previews: PreviewProvider {
    static let viewContext = PersistenceController.shared.container.viewContext
    
    static var previews: some View {
        let book = Book(context: viewContext)
        book.title = "a test name"
        book.author = "an author"
        
        return BookItem(book: book)
            .environmentObject(ImageLoader())
            .environment(
                \.managedObjectContext,
                viewContext
            )
            .previewLayout(.fixed(width: 120 + 10, height: 160 + 10))
    }
}
