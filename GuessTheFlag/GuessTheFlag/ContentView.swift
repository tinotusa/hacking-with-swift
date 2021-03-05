//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tino on 4/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var score = 0
    
    let angularStroke = AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
                                 center: .center)
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.7, blue: 1), .purple]),
                                            startPoint: .top,
                                            endPoint: .bottom)
    
    var body: some View {
        ZStack {
            backgroundGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text("\(countries[correctAnswer])")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        Image(countries[number])
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(angularStroke, lineWidth: 4)
                            )
                            .shadow(radius: 2)
                    }
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("Continue")) {
                    askQuestion()
                  }
            )
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            alertTitle = "Correct"
            alertMessage = "That is correct"
            score += 1
        } else {
            alertTitle = "Wrong"
            alertMessage = "That is the flag of \(countries[number])"
        }
        showingAlert = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
