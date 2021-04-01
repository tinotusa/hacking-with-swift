//
//  Rating.swift
//  Bookworm
//
//  Created by Tino on 1/4/21.
//

import SwiftUI

struct Rating: View {
    let label: String
    @Binding var rating: Int16
    
    let onImage = Image(systemName: "star.fill")
    let offImage: Image? = nil
    let onColor = Color.yellow
    let offColor = Color.gray
    let maxRating: Int = 5
        
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            ForEach(1 ..< maxRating + 1) { rating in
                image(for: rating)
                    .foregroundColor(color(for: rating))
                    .onTapGesture {
                        self.rating = Int16(rating)
                    }
            }
        }
    }
    
    func color(for rating: Int) -> Color {
        if rating <= self.rating {
            return onColor
        }
        return offColor
    }
    
    func image(for rating: Int) -> Image {
        if rating <= self.rating {
            return onImage
        }
        return offImage ?? onImage
    }
}


struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Rating(label: "lmao", rating: .constant(4))
    }
}
