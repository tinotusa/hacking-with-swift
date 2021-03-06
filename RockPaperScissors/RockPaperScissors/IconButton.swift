//
//  IconButtonView.swift
//  RockPaperScissors
//
//  Created by Tino on 6/3/21.
//

import SwiftUI

struct IconButton: View {
    let icon: String
    let text: String
    let action: () -> Void
    
    let background = LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing)
    
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(icon)
                    .font(.largeTitle)
                Text(text)
                    .font(.title)
                    .padding()
            }
            .frame(width: 200) // figure out how to not hardcode this value
            .foregroundColor(.white)
            .padding(.horizontal)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3)
        }
    }
}

struct IconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(icon: "✋", text: "Paper") { }
    }
}
