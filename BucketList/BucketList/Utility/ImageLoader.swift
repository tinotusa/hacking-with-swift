//
//  ImageLoader.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI

// this is broken somehow
class ImageLoader {
    var image: UIImage?
    
    func load(string url: String) -> UIImage? {
        guard let url = URL(string: url) else {
            print("invalid url")
            return nil
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: getImageFromRequest)
        task.resume()

        return image
    }
    
    private func getImageFromRequest(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else {
            print("There was no data found")
            return
        }
        image = UIImage(data: data)
    }
}
