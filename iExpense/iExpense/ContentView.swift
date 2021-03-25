//
//  ContentView.swift
//  iExpense
//
//  Created by Tino on 24/3/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddView = false
    @State private var sortByPrice = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    NavigationLink(destination: ItemDetail(item: item)) {
                        RowItem(item: item)
                    }
                }
                .onDelete(perform: expenses.removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                trailing:
                    HStack(spacing: 20) {
                        Button(action: {
                            showingAddView = true
                        }) {
                            Text("Add Item")
                        }

                        EditButton()
                    }
            )
        }
        .sheet(isPresented: $showingAddView) {
            AddView(expenses: expenses)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
