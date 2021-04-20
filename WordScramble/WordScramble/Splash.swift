//
//  Splash.swift
//  WordScramble
//
//  Created by Tino on 19/4/21.
//

import SwiftUI

struct Splash: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Constants.background
                    .ignoresSafeArea()
                VStack {
                    BlockLetters("Word")
                    BlockLetters("Scrable")
                }
            }
            
        }
    }
}

struct BlockLetters: View {
    let text: String
    @State private var shouldRotate = false
    @State private var shouldSlide = false
    
    let blockSize = CGFloat(50)
    let angleRange = -20.0 ... 20.0
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                ForEach(0 ..< text.count) { index in
                    // is this a bad thing to do (remake the array each time in the loop)?
                    BlockLetter(Array(text)[index])
                        .frame(width: blockSize, height: blockSize)
                        .rotationEffect(shouldRotate ?
                                            .degrees(Double.random(in: angleRange)) : .init(degrees: 0))
                        .offset(y: shouldSlide ? 0 : -proxy.size.height * 20)
                        
                }
            }
            .frame(width: proxy.size.width)
            .onAppear {
                withAnimation(Animation.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.2)) {
                    shouldSlide = true
                    shouldRotate = true
                }
            }
        }
        .frame(height: blockSize)
    }
}

struct BlockLetter: View {
    let letter: Character
    let radius = CGFloat(10)
    
    init (_ letter: Character) {
        self.letter = letter
    }
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .overlay(blockGradient)
                .cornerRadius(radius)
                .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 7)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color("darkBrown"), lineWidth: 5)
                )
            Text(String(letter))
                .font(.custom("kefa", size: 30))
                .foregroundColor(.white)
                .shadow(color: Color("darkBrown"), radius: 1, x: -2, y: 2)
        }
    }
    
    var blockGradient: some View {
        RadialGradient(gradient: Gradient(colors: [Color("blockGradientStart"), Color("blockGradientMiddle"), Color("blockGradientEnd")]),
                       center: .center,
                       startRadius: 1,
                       endRadius: 40
        )
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
