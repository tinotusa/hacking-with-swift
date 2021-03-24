//
//  RoundedBlueButton.swift
//  Edutainment
//
//  Created by Tino on 24/3/21.
//

import SwiftUI

struct RoundedBlueButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .frame(width: 100)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

extension View {
    func roundedBlueButton() -> some View {
        self.modifier(RoundedBlueButton())
    }
}
