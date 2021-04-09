//
//  FloatingButton.swift
//  Flashzilla
//
//  Created by Tino on 9/4/21.
//

import SwiftUI

struct FloatingButton: View {
    let action: () -> Void
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: action) {
                    Image(systemName: "plus.circle")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                }
            }
            Spacer()
        }
        .foregroundColor(.white)
        .font(.largeTitle)
        .padding()
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(action: {})
    }
}
