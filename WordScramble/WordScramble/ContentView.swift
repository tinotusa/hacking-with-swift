//
//  ContentView.swift
//  WordScramble
//
//  Created by Tino on 8/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSplash = false
    
    var body: some View {
        Group {
            if showingSplash {
                Splash()
            } else {
                GameScreen()
            }
        }
        .animation(.default)
        .onAppear {
            showingSplash = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                showingSplash = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
