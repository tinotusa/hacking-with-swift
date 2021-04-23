//
//  ContentView.swift
//  iExpense
//
//  Created by Tino on 24/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddScreen = false
    var body: some View {
        ZStack {
            Constants.background
                .ignoresSafeArea()
            Home()
            FloatingButton(action: { showingAddScreen = true })
        }
        .sheet(isPresented: $showingAddScreen) {
            AddExpense()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ExpenseTracker())
    }
}
