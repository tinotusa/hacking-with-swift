//
//  ImageSelectionView.swift
//  Bookworm
//
//  Created by Tino on 27/4/21.
//

import SwiftUI

struct ImageSelectionView: View  {
    let placeholder: String
    @Binding var selectedImage: UIImage?
    @Binding var imageURL: URL?
    @State private var showImagePicker = false
    @State private var image: Image? = nil
    
    init(_ placeholder: String = "Tap to select an image", selectedImage: Binding<UIImage?>, imageURL: Binding<URL?>) {
        self.placeholder = placeholder
        _selectedImage = selectedImage
        _imageURL = imageURL
    }
    
    let width: CGFloat = 120
    let height: CGFloat = 220
    
    var body: some View {
        ZStack {
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230, height: 230)
            } else {
                Rectangle()
                    .fill(Color.gray)
                Text(placeholder)
            }
            
        }
        .onTapGesture { showImagePicker = true }
        .sheet(isPresented: $showImagePicker, onDismiss: setImage) {
            ImagePicker(selectedImage: $selectedImage, imageURL: $imageURL)
        }
    }
    
    func setImage() {
        if let selectedImage = selectedImage {
            image = Image(uiImage: selectedImage)
        }
    }
}
