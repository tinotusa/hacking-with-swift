//
//  EditCards.swift
//  Flashzilla
//
//  Created by Tino on 8/4/21.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add new card")) {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0 ..< cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationBarTitle("Edit cards")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            .listStyle(GroupedListStyle())
            .onAppear(perform: loadData)
        }
    }
}

extension EditCards {
    static let saveKey = "Cards"
    func addCard() {
        let newPrompt = self.newPrompt.trimmingCharacters(in: .whitespacesAndNewlines)
        let newAnswer = self.newAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        if newPrompt.isEmpty || newAnswer.isEmpty { return }
        let newCard = Card(prompt: newPrompt, answer: newAnswer)
        cards.insert(newCard, at: 0)
        saveData()
    }
    
    func removeCards(atOffsets offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decodedCards = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decodedCards
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: Self.saveKey)
        }
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
