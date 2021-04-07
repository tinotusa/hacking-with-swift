//
//  FileManager-Documents.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import Foundation

extension FileManager {
    func documentsURL() -> URL {
        let paths = Self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
}
