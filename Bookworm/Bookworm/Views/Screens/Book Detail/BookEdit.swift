//
//  BookEdit.swift
//  Bookworm
//
//  Created by Tino on 27/4/21.
//

import SwiftUI

struct BookEdit: View {
    let book: Book
    @State private var selectedImage: UIImage? = nil
    @State private var imageURL: URL? = nil
    @Binding var bookInfo: BookInfo
    
    var body: some View {
        let urlBinding = Binding<URL?>(
            get: { imageURL },
            set: {
                imageURL = $0
                bookInfo.imagePath = imageURL!.lastPathComponent
            })
        return ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                ImageSelectionView("Tap to select a new book cover", selectedImage: $selectedImage, imageURL: urlBinding)
                    .frame(height: 200)
                Group {
                    Text("Title")
                    TextField(bookInfo.title, text: $bookInfo.title)
                }
                    
                Group {
                    Text("Author")
                    TextField(bookInfo.author, text: $bookInfo.author)
                }
                
                Group {
                    Text("Genre")
                    Picker("Genre", selection: $bookInfo.genre) {
                        ForEach(Genre.allCases) { genre in
                            Text(genre.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Text("Rating")
                RatingView(rating: $bookInfo.rating)
                
                Text("Review")
                TextView("What are your thoughts on this book", text: $bookInfo.review)
                
            }
            .textFieldStyle(MyTextFieldStyle())
            .foregroundColor(Color("fontColour"))
        }
        
    }
}
