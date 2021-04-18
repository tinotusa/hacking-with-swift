//
//  MenuButton.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import SwiftUI

struct MenuButton: View {
    let text: String
    let action: () -> Void
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(isPressed ? Color("pink").opacity(0.7) : Color.white)
            Text(text)
                .font(.custom("Varela Round", size: 56))
                .foregroundColor(Color("pink"))
        }
        .cornerRadius(31)
        .onTapGesture {
            withAnimation {
                isPressed.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    isPressed.toggle()
                }
            }
            action()
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton("Hello, world", action: {})
            .previewLayout(PreviewLayout.fixed(width: 340, height: 80))
    }
}
