//
//  View-Stacked.swift
//  Flashzilla
//
//  Created by Tino on 9/4/21.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}
