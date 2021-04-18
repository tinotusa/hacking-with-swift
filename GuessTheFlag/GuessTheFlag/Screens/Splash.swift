//
//  Splash.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import SwiftUI

struct Splash: View {
    let images: [Image] = [Image("Poland"), Image("Nigeria"), Image("Spain"), Image("Estonia")]
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                background
                
                SplashFlagView(image: images[0])
                    .rotationEffect(.degrees(-12.0))
                    .position(x: proxy.size.width * 0.9, y: proxy.size.height * 0.03)
                
                SplashFlagView(image: images[1])
                    .scaleEffect(1.5)
                    .rotationEffect(.degrees(25.0))
                    .position(x: proxy.size.width * 0.9, y: proxy.size.height * 0.5)
                    
                SplashFlagView(image: images[2])
                    .scaleEffect(1.5)
                    .rotationEffect(.degrees(23.0))
                    .position(x: proxy.size.width * 0.2, y: proxy.size.height * 0.95)
                
                SplashFlagView(image: images[3])
                    .rotationEffect(.degrees(46.0))
                    .position(x: proxy.size.width * 0.1, y: proxy.size.height * 0.20)
                
                VStack(spacing: -30) {
                    Text("Guess")
                        .font(.custom("Varela Round", size: proxy.size.width * 0.3))
                    Text("the")
                        .font(.custom("Varela Round", size: proxy.size.width * 0.2))
                    Text("flag")
                        .font(.custom("Varela Round", size: proxy.size.width * 0.4))
                        
                }
                .foregroundColor(Color("pink"))
                .shadow(color: .black, radius: 6, x: 0, y: 7)
                
            }
        }
    }
}

fileprivate struct SplashFlagView: View {
    let image: Image
    var body: some View {
        image
            .cornerRadius(10)
    }
}

private extension Splash {
    var background: some View {
        Color("blue")
            .ignoresSafeArea()
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
