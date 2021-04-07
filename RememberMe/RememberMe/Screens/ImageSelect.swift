//
//  ImageSelect.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import SwiftUI

struct ImageSelect: View {
    @Binding var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        ZStack {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .scaledToFit()
            } else {
                Rectangle()
                    .fill(Color.black.opacity(0.8))
                Text("Tap to add an image")
                    .foregroundColor(.white)
            }
        }
        .onTapGesture {
            showingImagePicker = true
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}

struct ImageSelect_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelect(selectedImage: .constant(nil))
    }
}
