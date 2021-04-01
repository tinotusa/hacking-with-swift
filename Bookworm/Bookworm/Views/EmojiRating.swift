//
//  EmojiRating.swift
//  Bookworm
//
//  Created by Tino on 1/4/21.
//

import SwiftUI


struct EmojiRating: View {
    let rating: Int16
    
    var body: some View {
        Text("\(rating)")
    }
}


struct EmojiRating_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRating(rating: 3)
    }
}
