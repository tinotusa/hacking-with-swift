//
//  ImageSelect.swift
//  Instafilter
//
//  Created by Tino on 28/4/21.
//

import SwiftUI

struct ImageSelect: View {
    let size: CGFloat = 400
    
    @State var image: Image? = nil
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        ZStack {
            if image != nil {
                imageView
            } else {
                grayImageSelectBox
            }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: setImage) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .onTapGesture {
            showImagePicker = true
        }
    }
}

private extension ImageSelect {
    var imageView: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
            Text("Tap image to select another")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var grayImageSelectBox: some View {
        Group {
            Rectangle()
                .fill(Color.gray)
            Text("Tap to select an image")
        }
    }
    
    func setImage() {
        if let selectedImage = selectedImage {
            image = Image(uiImage: selectedImage)
        }
    }
}

struct ImageSelect_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelect()
    }
}
