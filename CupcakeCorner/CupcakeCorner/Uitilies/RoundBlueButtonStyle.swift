//
//  RoundBlueButtonStyle.swift
//  CupcakeCorner
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct RoundBlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.gray : Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
