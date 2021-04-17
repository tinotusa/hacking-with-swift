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
        ZStack {
            background
            
            SplashFlagView(image: images[0])
                .rotationEffect(.degrees(-12.0))
                .position(x: 380, y: 30)
            
            SplashFlagView(image: images[1])
                .scaleEffect(1.5)
                .rotationEffect(.degrees(25.0))
                .position(x: 380, y: 300)
                
            SplashFlagView(image: images[2])
                .scaleEffect(1.5)
                .rotationEffect(.degrees(23.0))
                .position(x: 90, y: 780)
            
            SplashFlagView(image: images[3])
                .rotationEffect(.degrees(46.0))
                .position(x: 50, y: 89)
            
            VStack(spacing: 0) {
                Text("Guess")
                    .font(.custom("Varela Round", size: 130))
                Text("The")
                    .font(.custom("Varela Round", size: 86))
                Text("Flag")
                    .font(.custom("Varela Round", size: 167))
            }
            .foregroundColor(Color("pink"))
            .shadow(color: .black, radius: 6, x: 0, y: 7)
            
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
