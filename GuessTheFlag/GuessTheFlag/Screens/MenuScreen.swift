//
//  MenuScreen.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import SwiftUI

struct MenuScreen: View {
    @EnvironmentObject var settingsModel: SettingsModel
    
    @State private var showingSettings = false
    let widthPercentage = CGFloat(0.75)
    let heightPercentage = CGFloat(0.11)
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    background
                    
                    VStack(spacing: 40) {
                        Text("Guess the flag")
                            .font(.custom("Varela Round", size: proxy.size.width * 0.12))
                            .foregroundColor(Color("pink"))
                            .customUnderline()
                        
                        NavigationLink(destination: GameScreen()) {
                            MenuButton("Play", action: {})
                                .disabled(true) // don't want to use the button action just navigation
                                .frame(
                                    width: proxy.size.width * widthPercentage,
                                    height: proxy.size.height * heightPercentage
                                )
                        }

                        NavigationLink(destination: SettingsScreen()) {
                            MenuButton("Settings", action: {})
                                .disabled(true) // again, just want the navigation
                                .frame(
                                    width: proxy.size.width * widthPercentage,
                                    height: proxy.size.height * heightPercentage
                                )
                        }
                    }
                    .padding()
                    
                    Image("Flag pole")
                        .scaleEffect(1.3)
                        .position(x: proxy.size.width * 0.7, y: proxy.size.height * 0.98)
                }
                .navigationBarHidden(true)
            }
        }
        .onAppear {
            settingsModel.load()
        }
    }
}

private extension MenuScreen {
    var background: some View {
        Color("blue")
            .ignoresSafeArea()
    }
    
    func showSettings() {
        showingSettings = true
    }
}

struct MenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
            .environmentObject(SettingsModel())
    }
}
