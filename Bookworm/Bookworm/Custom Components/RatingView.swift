//
//  RatingView.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI


struct RatingView: View {
    @Binding var rating: Int16
    let label: String
    let maxRating: Int16
    init (_ label: String = "Rating", rating: Binding<Int16>, maxRating: Int16 = 5) {
        self.label = label
        _rating = rating
        self.maxRating = maxRating
    }
    
    var body: some View {
        HStack {
            ForEach(1 ..< Int(maxRating + 1)) { index in
                Image(systemName: "star.fill")
                    .foregroundColor(getColor(for: index))
                    .onTapGesture {
                        rating = Int16(index)
                    }
            }
        }
    }
    
    func getColor(for rating: Int) -> Color {
        if rating <= self.rating {
            return Color.yellow
        } else {
            return Color.gray
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
            .environmentObject(ImageLoader())
    }
}
