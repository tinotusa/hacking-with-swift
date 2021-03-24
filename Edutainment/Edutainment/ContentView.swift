//
//  ContentView.swift
//  Edutainment
//
//  Created by Tino on 24/3/21.
//

import SwiftUI

enum GameState {
    case settings, playing, gameOver
}

struct ContentView: View {
    @State private var gameState = GameState.settings
    @State private var timesTable = 1
    @State private var numberOfQuestions = ""
    
    var body: some View {
        switch gameState {
        case .settings:
            Settings(timesTable: $timesTable, numberOfQuestions: $numberOfQuestions, gameState: $gameState)
        case .playing:
            Game(timesTable: timesTable, numberOfQuestions: numberOfQuestions, gameState: $gameState)
        case .gameOver:
            Text("game over  lol")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
