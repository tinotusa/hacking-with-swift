//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Tino on 28/4/21.
//

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(_ uiImage: UIImage) {
        UIImageWriteToSavedPhotosAlbum(uiImage, self, #selector(saveError), nil)
    }
    
    @objc
    func saveError(_ uiImage: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("saved")
    }
}
