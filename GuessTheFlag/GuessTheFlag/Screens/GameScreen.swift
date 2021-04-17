//
//  GameScreen.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import SwiftUI
// MARK: - TODO
// add a close button that goes back to the main menu
// implement hint ui and functionality

struct GameScreen: View {
    @EnvironmentObject var settingsModel: SettingsModel
    
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US",
    ]
    
    @State private var choices: [String] = ["Nigeria", "Poland", "Russia"]
    @State private var correctAnswer = 0
    @State private var score = 0
    @State private var isCorrect = false
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            background
            
            NavigationLink(destination: Text("Game over"), isActive: $gameOver) { EmptyView() }
            
            VStack {
                Text("Tap the flag of")
                    .font(.custom("Varela Round", size: 40))
                    .foregroundColor(Color("pink"))
                
                Text(choices[correctAnswer])
                    .font(.custom("Varela Round", size: 60))
                    .foregroundColor(Color("green"))
                
                VStack(spacing: 30) {
                    imageButtons
                }
                
                Spacer()
                
                HStack {
                    Text("score: \(score)/\(settingsModel.numberOfQuestions)")
                    Spacer()
                    Text("hint")
                }
            }
            .padding()
            
//            if isCorrect {
//                Text("CORRECT")
//                    .font(.title)
//                    .scaleEffect()
//            }
        }
        .onAppear(perform: generateQuestion)
        .navigationBarHidden(true)
    }
}

struct FlagView: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 5))
            .frame(width: 320, height: 150)
            
    }
}

private extension GameScreen {
    var background: some View {
        Color("blue")
            .ignoresSafeArea()
    }
    
    var imageButtons: some View {
        ForEach(0 ..< choices.count) { index in
            FlagView(image: Image(choices[index]))
                .onTapGesture {
                    checkAnswer(answer: index)
                }
        }
    }
    
    func generateQuestion() {
        countries.shuffle()
        choices = Array(countries.prefix(3))
        correctAnswer = Int.random(in: 0..<choices.count)
    }
    
    func checkAnswer(answer: Int) {
        if answer == correctAnswer {
            score += 1
            isCorrect = true
        } else {
            isCorrect = false
        }
        if score == settingsModel.numberOfQuestions {
            gameOver = true
        }
        generateQuestion()
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen()
            .environmentObject(SettingsModel())
    }
}
