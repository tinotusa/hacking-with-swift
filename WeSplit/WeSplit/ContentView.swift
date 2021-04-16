//
//  ContentView.swift
//  WeSplit
//
//  Created by Tino on 3/3/21.
//

import SwiftUI

// MARK: - TODO
// fix geometry reader layouts

struct ContentView: View {
    @State private var showingSplash = true
    
    var body: some View {
        Group {
            if showingSplash {
                SplashScreen()
            } else {
                MainScreen()
                    .transition(.slide)
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
    }
}
