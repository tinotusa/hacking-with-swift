//
//  Game.swift
//  Edutainment
//
//  Created by Tino on 24/3/21.
//

import SwiftUI

struct Game: View {
    let timesTable: Int
    let numberOfQuestions: String
    @Binding var gameState: GameState
    
    init(timesTable: Int, numberOfQuestions: String, gameState: Binding<GameState>) {
        self.timesTable = timesTable + 1
        self.numberOfQuestions = numberOfQuestions
        _gameState = gameState
    }
    
    @State private var question = ""
    @State private var answer = ""
    @State private var multiple = randomMultiple()
    
    @State private var correctCount = 0
    @State private var incorrectCount = 0
    @State private var submitted = false
    @State private var correct = true
    
    @State private var count = 0
    
    var maxQuestions: Int {
        Int(numberOfQuestions) ?? 12
    }
    
    var result: Int {
        timesTable * multiple
    }
    
    var body: some View {
        VStack {
            Text("\(count) out of \(maxQuestions)")
            
            Spacer()
            
            Text("What is")
                .font(.largeTitle)
            
            Text(question)
            
            TextField("answer", text: $answer)
                .keyboardType(.decimalPad)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack(spacing: 10) {
                Button(action: checkAnswer) {
                    Text("Submit")
                        .roundedBlueButton()
                }
                .disabled(answer.isEmpty)
                
                Button(action: generateQuestion) {
                    Text("Next")
                        .roundedBlueButton()
                }
                .disabled(!submitted)
            }
            
            if submitted {
                if !correct {
                    Text("Wrong the answer was \(result)")
                        .transition(.slide)
                } else {
                    Text("Correct")
                        .transition(.slide)
                }
            }
            
            Spacer()
        }
        .onAppear {
            generateQuestion()
        }
        .transition(.slide)
    }
    
    func generateQuestion() {
        if count == maxQuestions {
            gameState = .gameOver
        }
        submitted = false
        multiple = Self.randomMultiple()
        question = "\(timesTable) x \(multiple)"
    }
    
    static func randomMultiple(in range: Range<Int> = 1 ..< 13) -> Int {
        Int.random(in: range)
    }
    
    func checkAnswer() {
        // if submitted again (without change, return)
//        if submitted {
//            answer = ""
//            submitted.toggle()
//            return
//        }
        count += 1
        submitted = true
        let answer = Int(self.answer) ?? 0
        if answer == result {
            correctCount += 1
            withAnimation {
                correct = true
            }
        } else {
            incorrectCount += 1
            withAnimation {
                correct = false
            }
        }
    }
}
struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game(timesTable: 1, numberOfQuestions: "5", gameState: .constant(GameState.playing))
    }
}
