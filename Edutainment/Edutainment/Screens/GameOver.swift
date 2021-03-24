//
//  GameOver.swift
//  Edutainment
//
//  Created by Tino on 24/3/21.
//

import SwiftUI

struct GameOver: View {
    let correctCount: Int
    let incorrectCount: Int
    let totalQuestions: Int
    
    var body: some View {
        VStack {
            Text("Game over")
                .font(.largeTitle)
            Text("You got: ")
                .font(.title3)
            Text("\(correctCount) out of \(totalQuestions) ")
                .font(.title)
                .fontWeight(.light) +
            Text("correct")
                .foregroundColor(.green)
                .fontWeight(.light)
                .font(.title)
            
            Text("\(incorrectCount) out of \(totalQuestions) ")
                .font(.title)
                .fontWeight(.light) +
            Text("wrong")
                .foregroundColor(.red)
                .fontWeight(.light)
                .font(.title)
            
            Button(action: {}) {
                Text("Play again")
                    .roundedBlueButton()
            }
        }
//        .navigationBarTitle("Game over")
    }
}

struct GameOver_Previews: PreviewProvider {
    static var previews: some View {
        GameOver(correctCount: 4, incorrectCount: 6, totalQuestions: 10)
    }
}
