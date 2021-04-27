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
            .scaleEffect(isLiked ? 1.2 : 1)
            .rotationEffect(.degrees(isLiked ? 360 : 0))
            .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0.3))
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
