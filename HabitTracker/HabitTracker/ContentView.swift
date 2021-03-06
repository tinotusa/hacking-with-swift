//
//  ContentView.swift
//  HabitTracker
//
//  Created by Tino on 31/3/21.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var tracker = Tracker()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tracker.habits) { habit in
                    NavigationLink(destination: HabitDetail(tracker: tracker, habit: habit)) {
                        HabitRow(habit: habit)
                    }
                }
                .onDelete(perform: tracker.removeHabit)
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabit(tracker: tracker)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: { showingAddHabit = true }) {
                        Text("Add habit")
                    }
                    EditButton()
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
