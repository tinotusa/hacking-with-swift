//
//  SettingsItem.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import SwiftUI

struct SettingsItem<Content: View>: View {
    let label: String
    let content: Content
    let size: CGFloat
    
    init(_ label: String, size: CGFloat = 12, content: Content) {
        self.label = label
        self.size = size
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            HStack {
                Text(label)
                    .font(.custom("Varela Round", size: size))
                    .foregroundColor(Color("pink"))
                Spacer()
                content
            }
            .padding()
        }
        .cornerRadius(27)
    }
}

struct SettingsItem_Previews: PreviewProvider {
    static var previews: some View {
        SettingsItem("Hello, world", size: 30, content: Button("Content", action: {}))
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
