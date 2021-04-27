//
//  MyTextFieldStyle.swift
//  Bookworm
//
//  Created by Tino on 27/4/21.
//

import SwiftUI

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color("textFieldColour"))
            .foregroundColor(Color("fontColour"))
    }
}
