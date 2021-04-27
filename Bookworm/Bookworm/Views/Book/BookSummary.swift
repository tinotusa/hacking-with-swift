//
//  BookSummary.swift
//  Bookworm
//
//  Created by Tino on 27/4/21.
//

import SwiftUI

struct BookSummary: View {
    let book: Book
    
    @EnvironmentObject var imageLoader: ImageLoader
    @State private var testText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                imageLoader.loadImage(path: book.wrappedImagePath)
                    .resizable()
                    .frame(width: Constants.bookWidth, height: Constants.bookHeight)
                VStack(alignment: .leading) {
                    Text(book.wrappedTitle.capitalized)
                        .lineLimit(3)
                        .font(.title)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    
                    Text(book.wrappedAuthor.capitalized)
                        .font(.title3)
                    Spacer()
                    
                    Text(book.wrappedGenre.capitalized)
                        .font(.title3)
                    Spacer()
                    
                    HStack {
                        RatingView(rating: .constant(book.rating))
                        Spacer()
                        LikeButton(isLiked: .constant(book.isFavourite))
                    }
                }
            }
            .frame(height: 160)
            
            Divider()
            
            Text("Thoughts")
                .font(.title)
            TextView(text: .constant(book.wrappedReview), isEditable: false)
        }
        .padding(.horizontal)
        .foregroundColor(Color("fontColour"))
    }
}
