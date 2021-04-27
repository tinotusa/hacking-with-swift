//
//  ImageLoader.swift
//  Bookworm
//
//  Created by Tino on 27/4/21.
//

import SwiftUI

class ImageLoader: Codable, ObservableObject {
    var images: [String: Image] = [:]
    
    var paths = [String]() {
        didSet {
            savePaths()
        }
    }
    
    init() {
        loadPaths()
        print("paths: \(paths)")
        loadImages()
    }
    
    enum CodingKeys: CodingKey {
        case paths
    }
    
    func loadImages() {
        for path in paths {
            images[path] = loadImage(path: path)
        }
    }
    
    func removePath(_ path: String) {
        if let index = paths.firstIndex(where: { $0 == path }) {
            paths.remove(at: index)
        }
    }
    
    func loadImage(path: String) -> Image {
        // MARK: - TODO
        // remove this
        if path == "N/A" {
            return Image("default")
        }
        if images[path] != nil {
            return images[path]!
        }
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documents.appendingPathComponent(path)
        
        do {
            let data = try Data(contentsOf: url)
            if let uiImage = UIImage(data: data) {
                if !paths.contains(path) {
                    paths.append(path)
                }
                images[path] = Image(uiImage: uiImage)
            } else {
                fatalError("Failed to load image data")
            }
        } catch {
//            fatalError("Error getting data from url (\(path))")
            return Image("default")
        }
        
        return images[path]!
    }
    
    private static let saveURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
        .appendingPathComponent("imagePaths.data")
    
    func loadPaths() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: Self.saveURL)
            paths = try decoder.decode([String].self, from: data)
            return
        } catch {
            print("Error loading image paths\n\(error)")
        }
        paths = []
    }
    
    func savePaths() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(paths)
            try data.write(to: Self.saveURL, options: .atomic)
        } catch {
            print("Error saving paths\n\(error.localizedDescription)")
        }
    }
}
