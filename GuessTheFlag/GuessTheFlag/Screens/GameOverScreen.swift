//
//  GameOverScreen.swift
//  GuessTheFlag
//
//  Created by Tino on 18/4/21.
//

import SwiftUI

struct GameOverScreen: View {
    @EnvironmentObject var settingsModel: SettingsModel
    @Environment(\.presentationMode) var presentationMode
    
    let score: Int
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                background
                VStack(spacing: 20) {
                    Spacer()
                    Text("Game over")
                        .font(.custom("Varela Round", size: 70))
                        .foregroundColor(Color("pink"))
                        .customUnderline()
                    Text("Score: \(score)/\(settingsModel.numberOfQuestions)")
                        .font(.custom("Varela Round", size: 50))
                        .foregroundColor(Color("green"))
                    Group {
                        MenuButton("Play again", action: playAgain)
                        MenuButton("Quit", action: quit)
                    }
                    .frame(width: buttonWidth(proxy: proxy), height: buttonHeight(proxy: proxy))
                    Spacer()
                }
                .frame(width: proxy.size.width)
            }
        }
        .navigationBarHidden(true)
    }
}

private extension GameOverScreen {
    var background: some View {
        Color("blue")
            .ignoresSafeArea()
    }
    
    func buttonWidth(proxy: GeometryProxy) -> CGFloat {
        proxy.size.width * 0.8
    }
    
    func buttonHeight(proxy: GeometryProxy) -> CGFloat {
        proxy.size.height * 0.1
    }
    
    func playAgain() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func quit() {
        // don't know how to pop to root view
    }
}

struct GameOverScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameOverScreen(score: 8)
            .environmentObject(SettingsModel())
    }
}
