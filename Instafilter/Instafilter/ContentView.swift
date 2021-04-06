//
//  ContentView.swift
//  Instafilter
//
//  Created by Tino on 4/4/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    // MARK: properties
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterScale = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage:  UIImage?
    
    @State private var showingActionSheet = false
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = .sepiaTone()
    let context = CIContext()
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // MARK: body
    var body: some View {
        let intensity = Binding<Double>(
            get: { filterIntensity },
            set: {
                filterIntensity = $0
                applyProcessing()
            }
        )
        
        let scale = Binding<Double>(
            get: { filterScale },
            set: {
                filterScale = $0
                applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                OptionalImageSelect(image: $image) { showingImagePicker = true }
                
                VStack {
                    HStack {
                        Text("Intensity")
                            .frame(width: 70)
                        Slider(value: intensity)
                    }
                    HStack {
                        Text("Scale")
                            .frame(width: 70)
                        Slider(value: scale)
                    }
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change filter (\(currentFilter.name))") { showingActionSheet = true }
                    
                    Spacer()
                    
                    Button("Save", action: saveImage)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(uiImage: $inputImage)
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Filter selection"),
                    message: Text("Select a filter"),
                    buttons: [
                        .default(Text("Crystallize"))   { setFilter( .crystallize())    },
                        .default(Text("Edges"))         { setFilter( .edges())          },
                        .default(Text("Gaussian Blur")) { setFilter( .gaussianBlur())   },
                        .default(Text("Pixellate"))     { setFilter( .pixellate())      },
                        .default(Text("Sepia Tone"))    { setFilter( .sepiaTone())      },
                        .default(Text("Unsharp Mask"))  { setFilter( .unsharpMask())    },
                        .default(Text("Vignette"))      { setFilter( .vignette())       },
                        .cancel()
                    ]
                )
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {}
                )
            }
        }
    }
}

// MARK: Functions
extension ContentView {
    func saveImage() {
        guard let processedImage = self.processedImage else {
            showingAlert = true
            alertTitle = "Error"
            alertMessage = "There is no image to save"
            return
        }

        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success")
        }
        imageSaver.errorHandler = {
            print("Error: \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func loadImage() {
        guard let uiImage = inputImage else { return }
        let beginImage = CIImage(image: uiImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let keys = currentFilter.inputKeys
        if keys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if keys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if keys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 100, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
