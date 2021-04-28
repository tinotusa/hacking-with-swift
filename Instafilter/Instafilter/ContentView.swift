//
//  ContentView.swift
//  Instafilter
//
//  Created by Tino on 4/4/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilter

class ImageSaver: NSObject {
    func writeToPhotoAlbum(_ uiImage: UIImage) {
        UIImageWriteToSavedPhotosAlbum(uiImage, self, #selector(saveError), nil)
    }
    
    @objc
    func saveError(_ uiImage: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("saved")
    }
}

struct ContentView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var image: Image? = nil
    @State private var value = 0.0
    let context = CIContext()
    let imageSaver = ImageSaver()
    
    var body: some View {
        let valueBinding = Binding<Double>(
            get: { value },
            set: {
                value = $0
                filter(inputImage: selectedImage)
            })

        return VStack {
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
            } else {
                ImageSelect(selectedImage: $selectedImage, image: $image)
            }
            // edit image
            Slider(value: valueBinding)
            // save image
            Button("Save", action: savePhoto)
        }
    }
    
    func savePhoto() {
        if let selectedImage = selectedImage {
            imageSaver.writeToPhotoAlbum(selectedImage)
//            image = nil
        }
    }
    
    func filter(inputImage: UIImage?) {
        guard let inputImage = inputImage else { return }
        let ciImage = CIImage(image: inputImage)!
        guard let sepiaTone = sepiaFilter(ciImage, intensity: value) else { return }
        
        if let cgImage = context.createCGImage(sepiaTone, from: sepiaTone.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            selectedImage = uiImage
            image = Image(uiImage: uiImage)
        }
    }
    
    func sepiaFilter(_ inputImage: CIImage, intensity: Double) -> CIImage? {
        let sepiaFilter = CIFilter(name: "CISepiaTone")!
        sepiaFilter.setValue(inputImage, forKey: kCIInputImageKey)
        sepiaFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        return sepiaFilter.outputImage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
