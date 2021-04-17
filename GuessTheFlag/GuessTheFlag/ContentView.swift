//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tino on 4/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSplash = true
    
    var body: some View {
        Group {
            if showingSplash {
                Splash()
            } else {
                MenuScreen()
                    .transition(.scale)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showingSplash = false
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SettingsModel())
    }
}
