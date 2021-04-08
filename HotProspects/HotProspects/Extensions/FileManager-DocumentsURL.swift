//
//  FileManager-DocumentsURL.swift
//  HotProspects
//
//  Created by Tino on 8/4/21.
//

import Foundation

extension FileManager {
    func documentsURL() -> URL {
        let path = Self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first!
    }
}
