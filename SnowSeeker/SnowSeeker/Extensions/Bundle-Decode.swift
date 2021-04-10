//
//  Bundle-Decode.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ filename: String) -> T {
        guard let url = self.url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to decode \(filename): Invalid URL")
        }
        guard let fileData = try? Data(contentsOf: url) else {
            fatalError("Error: Failed get data from \(filename)")
        }
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: fileData)
            return decodedData
        } catch {
            print("Unresolved error: \(error.localizedDescription)")
            fatalError("Shouldn't happen")
        }
    }
}
