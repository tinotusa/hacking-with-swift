//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tino on 8/4/21.
//

// MARK: - TODO
// add timer
// make ui pretty

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

struct EditScreen: View {
    @EnvironmentObject var userData: UserData
    @State private var showingAddQuestionScreen = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.cards) { card in
                    VStack {
                        Text("Q: \(card.question)")
                            .font(.headline)
                        Text("A: \(card.answer)")
                            .font(.caption)
                    }
                    
                }
                .onDelete(perform: userData.remove)
            }
            .navigationTitle("Questions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Question") {
                        showingAddQuestionScreen = true
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingAddQuestionScreen) {
                AddQuestionView()
            }
        }
    }
}


struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            // show cards
            VStack {
                ZStack {
                    ForEach(userData.cards) { card in
                        CardView(card: card)
                            .offset(x: 0, y: CGFloat(userData.cards.count - (getIndex(of: card, in: userData.cards) ?? 0) * 10))
                            .disabled(getIndex(of: card, in: userData.cards) ?? 0 < userData.cards.count - 1)
                    }
                }
            }
            
            editQuestionsButton
            resetButton
            
            if userData.cards.isEmpty {
                GameOverView()
            }
        }
        .background(Color.gray)
        .sheet(isPresented: $showingEditScreen) {
            EditScreen()
        }
    }
    
    private func getIndex(of card: Card, in cards: [Card]) -> Int? {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            return index
        }
        return nil
    }
    
    private var editQuestionsButton: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    showingEditScreen = true
                } label: {
                    Text("edit questions")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
            Spacer()
        }
        .padding(.vertical)
    }
    
    private var resetButton: some View {
        VStack {
            HStack {
                Button {
                    userData.reset()
                    
                } label: {
                    Text("Reset")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
