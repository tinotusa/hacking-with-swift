//
//  OptionalImageSelect.swift
//  Instafilter
//
//  Created by Tino on 5/4/21.
//

import SwiftUI

struct OptionalImageSelect: View {
    @Binding var image: Image?
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.secondary)
            
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Tap to select a picture")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        .onTapGesture(perform: action)
    }
}


struct OptionalImageSelect_Previews: PreviewProvider {
    static var previews: some View {
        OptionalImageSelect(image: .constant(nil)) {}
    }
}
