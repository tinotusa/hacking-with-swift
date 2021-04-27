//
//  LikeButton.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI


struct LikeButton: View {
    @Binding var isLiked: Bool
    
    var body: some View {
        Image(systemName: "heart.fill")
            .font(.title)
            .foregroundColor(isLiked ? .red : .gray)
            .scaleEffect(isLiked ? 1.3 : 1)
            .animation(.interpolatingSpring(stiffness: 200, damping: 5))
            .onTapGesture {
                isLiked.toggle()
            }
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(isLiked: .constant(false))
    }
}
