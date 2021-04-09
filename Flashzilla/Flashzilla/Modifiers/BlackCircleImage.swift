//
//  BlackCircleImage.swift
//  Flashzilla
//
//  Created by Tino on 9/4/21.
//

import Foundation
import SwiftUI

struct BlackCircleImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.black.opacity(0.7))
            .clipShape(Circle())
    }
}

extension View {
    func blackCircleImage() -> some View {
        self.modifier(BlackCircleImage())
    }
}
