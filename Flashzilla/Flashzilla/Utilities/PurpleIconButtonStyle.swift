//
//  PurpleIconButtonStyle.swift
//  Flashzilla
//
//  Created by Tino on 2/9/21.
//

import SwiftUI

struct PurpleIconButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title)
            .padding()
            .foregroundColor(Color("textColour"))
            .background(Color("foreground"))
            .clipShape(Circle())
    }
}
