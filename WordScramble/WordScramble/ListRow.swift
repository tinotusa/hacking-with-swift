//
//  ListRow.swift
//  WordScramble
//
//  Created by Tino on 19/4/21.
//

import SwiftUI

struct ListRow: View {
    let word: String
    let radius = CGFloat(18)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .fill(Color("darkBrown"))
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color("lightBrown"), lineWidth: 4)
                )
            HStack {
                Letters(word)
                Spacer()
                Letters("\(word.count)")
            }
        }
    }
    
    private struct Letters: View {
        let text: String
        let size = CGFloat(40)
        var shouldDisplayBlock = false
        
        init(_ text: String) {
            self.text = text
            if text.count <= 6 {
                shouldDisplayBlock = true
            }
        }
        
        var body: some View {
            HStack {
                if shouldDisplayBlock {
                    ForEach(0 ..< text.count) { index in
                        BlockLetter(Array(text)[index])
                            .frame(width: size, height: size)
                    }
                } else {
                    Text(text)
                        .font(.custom("kefa", size: 30))
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                }
            }
            .padding(.horizontal)
        }
    }
}


struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(word: "really")
    }
}
