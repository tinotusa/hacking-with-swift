//
//  GameScreen.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import SwiftUI

struct GameScreen: View {
    @EnvironmentObject var settingsModel: SettingsModel
    @Environment(\.presentationMode) var presentationMode

    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US",
    ]
    
    @State private var choices: [String] = ["Nigeria", "Poland", "Russia"]
    @State private var correctAnswer = 0
    @State private var score = 0
    @State private var isCorrect = false
    @State private var gameOver = false
    @State private var hintChoice = 0
    @State private var showingHint = false

    var body: some View {
        ZStack {
            NavigationLink(destination: GameOverScreen(score: score), isActive: $gameOver) { EmptyView() }
            GeometryReader { proxy in
            background
                VStack(spacing: 20) {
                    Spacer()
                    Text("Tap the flag of")
                        .font(.custom("Varela Round", size: proxy.size.width * 0.1))
                        .foregroundColor(Color("pink"))
                    
                    Text(choices[correctAnswer])
                        .font(.custom("Varela Round", size: proxy.size.width * 0.15))
                        .foregroundColor(Color("green"))
                    
                    imageButtons
                        .frame(width: proxy.size.width * 0.8, height: proxy.size.width * 0.35)
                    
                    HStack(alignment: .bottom) {
                        scoreLabel
                        Spacer()
                        hintButton
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
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
                .opacity(showingHint && index == hintChoice ? 0.2 : 1)
                .colorMultiply(showingHint && index == hintChoice ? .red : .white)
        }
    }
    
    var scoreLabel: some View {
        VStack(spacing: 0) {
            Text("Score")
                .font(.custom("Varela Round", size: 35))
                .foregroundColor(Color("green"))
            Text("\(score) / \(settingsModel.numberOfQuestions)")
                .font(.custom("Varela Round", size: 33))
                .foregroundColor(Color("pink"))
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                )
        }
    }
    
    var hintButton: some View {
        Button(action: showHint) {
            Text("Hint")
                .font(.custom("Varela Round", size: 20))
                .foregroundColor(Color("pink"))
                .padding(22)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .padding(4)
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
        }
    }
    
    func showHint() {
        // highlights one of the wrong choices
        // leaving two others (one correct, one incorrect)
        hintChoice = 0
        repeat {
            hintChoice = Int.random(in: 0 ..< choices.count)
        } while hintChoice == correctAnswer
        showingHint = true
    }

    func generateQuestion() {
        countries.shuffle()
        choices = Array(countries.prefix(3))
        correctAnswer = Int.random(in: 0..<choices.count)
        showingHint = false
    }
    
    func checkAnswer(answer: Int) {
        if answer == correctAnswer {
            score += 1
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
