//
//  AverageColour.swift
//  BucketList
//
//  Created by Tino on 30/4/21.
//

import SwiftUI
import CoreImage



func averageColour(in inputImage: UIImage) -> UIColor? {
    let filter = "CIAreaAverage"
    guard let averageFilter = CIFilter(name: filter) else { return nil }
    guard let inputImage = CIImage(image: inputImage) else { return nil }
    
    averageFilter.setValue(inputImage, forKey: kCIInputImageKey)
    averageFilter.setValue(inputImage.extent, forKey: kCIInputExtentKey)
    
    guard let outputImage = averageFilter.outputImage else { return nil }
    
    let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
    
    var bitmap = [UInt8](repeating: 0, count: 4)
    context.render(
        outputImage,
        toBitmap: &bitmap,
        rowBytes: 4,
        bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
        format: .RGBA8,
        colorSpace: nil
    )
    
    return UIColor(
        red: CGFloat(bitmap[0]) / 255,
        green: CGFloat(bitmap[1]) / 255,
        blue: CGFloat(bitmap[2]) / 255,
        alpha: CGFloat(bitmap[3]) / 255
    )
}
