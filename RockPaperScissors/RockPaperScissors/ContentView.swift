//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Tino on 6/3/21.
//

import SwiftUI

struct ContentView: View {
    enum Choice: String, CaseIterable {
        case rock, paper, scissors
        
        static func random() -> Choice {
            let randIndex = Int.random(in: 0 ..< Choice.allCases.count)
            var choice: Choice = .rock
    
            switch randIndex {
            case 0: choice = .rock
            case 1: choice = .paper
            case 2: choice = .scissors
            default: break
            }
            
            return choice
        }
        
        func icon() -> String {
            switch self {
            case .rock: return "✊"
            case .paper: return "✋"
            case .scissors: return "✌️"
            }
        }
    }
    let maxScore = 5
    
    @State private var computerChoice = Choice.random()
    @State private var winCondition = ["lose", "win"].shuffled()
    @State private var score = 0
    @State private var showingAlert = false
    let alertTitle = "Game over"
    @State private var alertMessage = "Well done the game is over"
    
    let winsAgainst: [Choice: Choice] = [
        .rock    : .scissors,
        .paper   : .rock,
        .scissors: .paper
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                Text("\(winCondition.first!)")
                    .foregroundColor(winCondition.first! == "win" ? .green : .red)
                    .font(.largeTitle)
                    .fontWeight(.medium) +
                Text(" against \(computerChoice.rawValue)")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.white)

                
                VStack(spacing: 10) {
                    ForEach(Choice.allCases, id: \.self) { choice in
                        IconButton(icon: choice.icon(), text: "\(choice.rawValue.capitalized)") {
                            choicePicked(choice)
                        }
                    }
                    Text("Score: \(score)")
                        .lightWhiteText()
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("Resart game")) {
                        resetGame()
                      }
                )
            }
        }
    }
    
    func choicePicked(_ userChoice: Choice) {
        let userHasWon = winsAgainst[userChoice] == computerChoice
        let supposedToWin = winCondition.first! == "win"
        if supposedToWin && userHasWon {
            score += 1
            // if supposed to lose and the choice is not a draw or the user lost
        } else if !supposedToWin && (userChoice != computerChoice) && !userHasWon {
            score += 1
        }
        
        startAgain()
    }
    
    func startAgain() {
        if score == maxScore {
            showingAlert = true
        }
        computerChoice = Choice.random()
        winCondition = ["lose", "win"].shuffled()
    }
    
    func resetGame() {
        score = 0
        computerChoice = Choice.random()
        winCondition = ["lose", "win"].shuffled()
    }
}

struct LightWhiteText: ViewModifier {
    let font = Font.system(.title).weight(.light)
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(font)
    }
}

extension View {
    func lightWhiteText() -> some View {
        modifier(LightWhiteText())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
