//
//  LabeledImage.swift
//  Bookworm
//
//  Created by Tino on 1/4/21.
//

import SwiftUI

struct LabeledImage: View {
    let label: String
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(label)
                .resizable()
                .scaledToFit()

            Text(label.uppercased())
                .font(.caption)
                .fontWeight(.black)
                .padding(8)
                .foregroundColor(.white)
                .background(Color.black.opacity(0.75))
                .clipShape(Capsule())
                .offset(x: -5, y: -5)
        }
    }
}

struct LabeledImage_Previews: PreviewProvider {
    static var previews: some View {
        LabeledImage(label: "Other")
    }
}
