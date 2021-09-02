//
//  GameOverView.swift
//  Flashzilla
//
//  Created by Tino on 29/8/21.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            Spacer()
            
            Group {
                Text("Time remaining: \(userData.timeRemaining)")
                Text("Correct: \(userData.correctCount)")
                Text("Incorrect: \(userData.incorrectCount)")
            }
            .font(.title)
            .foregroundColor(Color("textColour"))
            
            HStack {
                Button("Play again") {
                    userData.reset()
                }
                .font(.title)
                .padding()
                .foregroundColor(Color("textColour"))
            }
            .padding(.top)
            .background(Color("foreground"))
            .frame(width: 570, height: 180)
            .cornerRadius(10)
            .shadow(color: .black, radius: 1, x: 0, y: 3)
            
        }
        .padding()
        .background(Color("foreground"))
        .cornerRadius(10)
        .shadow(radius: 5)
        
    }
}
struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
            .environmentObject(UserData())
            .environmentObject(UserData())
    }
}
