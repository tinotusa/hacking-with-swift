//
//  RoundedTextField.swift
//  WeSplit
//
//  Created by Tino on 16/4/21.
//

import SwiftUI

struct RoundedTextField: View {
    let placeholder: String
    @Binding var text: String
    @State private var isEditing = false
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))

            Group {
                if isEditing || !text.isEmpty{
                    Text("")
                } else {
                    Text(placeholder)
                }
            }
            .foregroundColor(Color(.systemGray))
            .font(.title)
            
            TextField("", text: $text) { isEditing in
                withAnimation {
                    self.isEditing = isEditing
                }
            }
            .font(.title)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
        }
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTextField("testing", text: .constant("some input"))
    }
}
