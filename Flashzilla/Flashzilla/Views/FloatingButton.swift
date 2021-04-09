//
//  FloatingButton.swift
//  Flashzilla
//
//  Created by Tino on 9/4/21.
//

import SwiftUI

struct FloatingButton: View {
    enum Position {
        case topLeading, topTrailing
        case bottomLeading, bottomTrailing
    }
    
    let image: Image
    let position: Position
    let action: () -> Void

    init(image: Image, position: Position = .bottomTrailing, action: @escaping () -> Void) {
        self.image = image
        self.position = position
        self.action = action
    }
    
    var body: some View {
        VStack {
            if position == .bottomLeading || position == .bottomTrailing {
                Spacer()
            }
            HStack {
                switch position {
                case .topLeading, .bottomLeading:
                    button
                    Spacer()
                case .topTrailing, .bottomTrailing:
                    Spacer()
                    button
                }
            }
            if position == .topLeading || position == .topTrailing {
                Spacer()
            }
        }
        .foregroundColor(.white)
        .font(.largeTitle)
        .padding()
    }
    
    var button: some View {
        Button(action: action) {
            image
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(
            image: Image(systemName: "plus.circle"),
            position: .topLeading,
            action: {})
    }
}
