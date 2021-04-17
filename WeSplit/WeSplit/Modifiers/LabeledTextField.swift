//
//  LabeledTextField.swift
//  WeSplit
//
//  Created by Tino on 17/4/21.
//

import SwiftUI

struct LabeledTextField: ViewModifier {
    let title: String
    let alignment: HorizontalAlignment
    
    init(alignment: HorizontalAlignment = .center, title: String) {
        self.title = title
        self.alignment = alignment
    }
    
    func body(content: Content) -> some View {
        VStack(alignment: alignment, spacing: 0) {
            Text(title)
                .font(.title3)
                .foregroundColor(.white)
            content
        }
    }
}


extension View {
    func labeledTextField(alignment: HorizontalAlignment = .center, title: String) -> some View {
        modifier(LabeledTextField(alignment: alignment, title: title))
    }
}
