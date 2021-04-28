//
//  ImagePicker.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var imageURL: URL?
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    init(selectedImage: Binding<UIImage?>, imageURL: Binding<URL?>) {
        _selectedImage = selectedImage
        _imageURL = imageURL
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        picker.delegate = context.coordinator
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            picker.sourceType = .savedPhotosAlbum
        }
        
        return picker
    }
    
    func updateUIViewController(_ picker: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            let url = info[.imageURL] as! URL
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let movedURL = documents.appendingPathComponent(url.lastPathComponent)
            do {
                try FileManager.default.moveItem(at: url, to: movedURL)
                parent.imageURL = movedURL
                parent.selectedImage = info[.originalImage] as? UIImage
            } catch {
                print(error.localizedDescription)
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
}
