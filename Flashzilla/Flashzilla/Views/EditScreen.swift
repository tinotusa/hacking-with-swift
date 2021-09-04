//
//  EditScreen.swift
//  Flashzilla
//
//  Created by Tino on 30/8/21.
//

import SwiftUI


struct EditScreen: View {
    @EnvironmentObject var userData: UserData
    @State private var showingAddQuestionScreen = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            ForEach(userData.cards) { card in
                VStack(alignment: .leading) {
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
                Button {
                    showingAddQuestionScreen = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .dismissable {
            presentationMode.wrappedValue.dismiss()
        }
        .sheet(isPresented: $showingAddQuestionScreen) {
            AddQuestionView()
        }
    }
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditScreen()
            .environmentObject(UserData())
    }
}
