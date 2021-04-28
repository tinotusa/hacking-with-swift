//
//  ContentView.swift
//  Instafilter
//
//  Created by Tino on 4/4/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilter

struct ContentView: View {
    let context = CIContext()
    let imageSaver = ImageSaver()
    static let filters = [
        "CIPhotoEffectNoir", "CIVignette", "CIBloom", "CIPhotoEffectFade",
        "CIPixellate",
    ]
    
    @State private var selectedImage: UIImage? = nil
    @State private var processedImage: UIImage? = nil
    @State private var image: Image? = nil

    @State private var intensity = 0.0
    @State private var radius = 1.0
    @State private var scale = 1.0
    @State private var currentFilter = Self.filters.first!
    @State private var showFilters = false
    
    var body: some View {
        // MARK: - Custom bindings
        let intensityBinding = Binding<Double>(
            get: { intensity },
            set: {
                intensity = $0
                applyFilter()
            }
        )
        let radiusBinding = Binding<Double>(
            get: { radius },
            set: {
                radius = $0
                applyFilter()
            }
        )
        
        let scaleBinding = Binding<Double>(
            get: { scale },
            set: {
                scale = $0
                applyFilter()
            }
        )
        // MARK: - Body
        return VStack {
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
            } else {
                ImageSelect(selectedImage: $selectedImage, image: $image)
            }
            
            HStack {
                Button("Filter: \(currentFilter)") { showFilters = true }
                Spacer()
                Button("Save", action: savePhoto)
            }
            
            Group {
                Text("Intensity")
                Slider(value: intensityBinding, in: 0 ... 1, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
                    Text("Intensity")
                }
                
                Text("Radius")
                Slider(value: radiusBinding, in: 0 ... 1, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
                    Text("Radius")
                }
                
                Text("Scale")
                Slider(value: scaleBinding, in: 0 ... 100, minimumValueLabel: Text("0"), maximumValueLabel: Text("100")) {
                    Text("Scale")
                }
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .actionSheet(isPresented: $showFilters) {
            ActionSheet(
                title: Text("Filters"),
                message: Text("Select a filter"),
                buttons: buttons
            )
        }
    }
}

// MARK: - Functions
private extension ContentView {
    var buttons: [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = []
        for filter in Self.filters {
            buttons.append(
                .default(Text(filter)) {
                    setFilter(to: filter)
                }
            )
        }
        buttons.append(.cancel())
        return buttons
    }
    
    func setFilter(to filter: String) {
        currentFilter = filter
//        if let inputImage = inputImage {
//            applyFilter(inputImage: selectedImage)
//        }
    }
    
    func savePhoto() {
        if let processedImage = processedImage {
            imageSaver.writeToPhotoAlbum(processedImage)
        }
    }
    
    func applyFilter() {
        guard let inputImage = selectedImage else { return }
        let ciImage = CIImage(image: inputImage)!
        
        let filter = CIFilter(name: currentFilter)!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        for key in filter.inputKeys {
            switch key {
            case kCIInputIntensityKey:
                filter.setValue(intensity, forKey: key)
            case kCIInputRadiusKey:
                filter.setValue(radius, forKey: key)
            case kCIInputScaleKey:
                filter.setValue(scale, forKey: key)
            default:
                break;
            }
        }
        
        let output = filter.outputImage!
        
        if let cgImage = context.createCGImage(output, from: output.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            processedImage = uiImage
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
