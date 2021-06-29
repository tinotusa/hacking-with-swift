//
//  QRCodeView.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    var text: String
    var context = CIContext()
    
    var body: some View {
        qrImage
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
    
    private var qrImage: Image {
        let qrFilter = CIFilter.qrCodeGenerator()
        let data = Data(text.utf8)
        qrFilter.setValue(data, forKey: "inputMessage")
        
        guard let outputImage = qrFilter.outputImage else {
            fatalError("failed to create output image from qr filter")
        }
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            fatalError("failed to create cgimage from coreimage context")
        }
        
        let uiImage = UIImage(cgImage: cgImage)
        return Image(uiImage: uiImage)
    }
}


struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(text: "name\nsomeemail@testing.com")
    }
}
