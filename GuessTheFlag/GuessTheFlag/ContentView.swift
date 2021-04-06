//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tino on 4/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var score = 0
    @State private var rotationAmount = 0.0
    @State private var opacity = 1.0
    
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.7, blue: 1), .purple]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    var flagName: String {
        countries[correctAnswer]
    }
    
    var body: some View {
        ZStack {
            backgroundGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text("\(flagName)")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                .accessibility(label: Text("Tap the flag of \(flagName)"))
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        FlagView(for: countries[number])
                            .accessibility(label: Text(labels[countries[number], default: "Unknown flag"]))
                    }
                    .rotationEffect(isCorrect(number) ? .degrees(rotationAmount) : .zero)
                    .opacity(isCorrect(number) ? 1 : opacity)
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
    
    func isCorrect(_ number: Int) -> Bool {
        correctAnswer == number
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            alertTitle = "Correct"
            alertMessage = "That is correct"
            score += 1
            withAnimation {
                rotationAmount += 360
            }
        } else {
            alertTitle = "Wrong"
            alertMessage = "That is the flag of \(countries[number])"
            withAnimation {
                opacity = 0.25
            }
        }
        showingAlert = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
        withAnimation {
            opacity = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
