//
//  AddQuestionView.swift
//  Flashzilla
//
//  Created by Tino on 30/8/21.
//

import SwiftUI

struct AddQuestionView: View {
    @State private var question = ""
    @State private var answer = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Question", text: $question)
                TextField("Answer", text: $answer)
                
                Button("Add") {
                    let card = Card(question: question, answer: answer)
                    userData.addCard(card)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(!allFieldsFilled)
            }
            .navigationTitle("Add Question")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var allFieldsFilled: Bool {
        let question = question.trimmingCharacters(in: .whitespacesAndNewlines)
        let answer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
        return !question.isEmpty && !answer.isEmpty
    }
}

struct AddQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuestionView()
    }
}
