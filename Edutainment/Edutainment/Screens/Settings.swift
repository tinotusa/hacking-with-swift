//
//  Settings.swift
//  Edutainment
//
//  Created by Tino on 24/3/21.
//

import SwiftUI

struct Settings: View {
    @Binding var timesTable: Int
    @Binding var numberOfQuestions: String
    @Binding var gameState: GameState
    
    let questions = ["5", "10", "20", "All"]
    
    var allFormsFilled: Bool {
        !numberOfQuestions.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Times table")) {
                    Picker("Times table", selection: $timesTable) {
                        ForEach(1..<13) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section(header: Text("Number of questions")) {
                    Picker("Questions", selection: $numberOfQuestions) {
                        ForEach(questions, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Button(action: {
                    withAnimation {
                        gameState = .playing
                    }
                }) {
                    Text("Start game")
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
                .disabled(!allFormsFilled)
            }
            .navigationBarTitle("Settings")
        }
        .transition(.slide)
    }
}





struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(timesTable: .constant(2), numberOfQuestions: .constant("5"), gameState: .constant(.settings))
    }
}
