//
//  FileManager-DocumentsURL.swift
//  iExpense
//
//  Created by Tino on 23/4/21.
//

import SwiftUI

extension FileManager {
    func documentsURL() -> URL {
        let urls = Self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.first!
    }
}
