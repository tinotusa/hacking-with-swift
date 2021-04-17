//
//  SplashScreen.swift
//  WeSplit
//
//  Created by Tino on 16/4/21.
//

import SwiftUI


struct SplashScreen: View {
    let gradientColors: [Color] = [Color("orange").opacity(0.7), Color("blue")]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: gradientColors),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            Group {
                Text("We")
                    .foregroundColor(Color("orange")) +
                Text("Split ")
                    .foregroundColor(Color("blue"))
                    
            }
            .shadow(color: Color.black, radius: 8, x: 0, y: 8)
        }
        .font(.custom("SignPainter", size: 110))
    }
}


struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
