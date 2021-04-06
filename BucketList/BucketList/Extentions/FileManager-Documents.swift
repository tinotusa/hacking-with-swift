//
//  FileManager-Documents.swift
//  BucketList
//
//  Created by Tino on 6/4/21.
//

import Foundation

extension FileManager {
    func documentsURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
}
