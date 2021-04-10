//
//  ContentView.swift
//  DiceRoll
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

class DiceRoller: ObservableObject {
    @Published private(set) var results: [[Int]]
    @Published var sides: Int
    @Published var rollCount: Int
    
    init(sides: Int = 6, rollCount: Int = 1) {
        results = []
        self.sides = sides
        self.rollCount = rollCount
    }
    
    func roll() {
        var tempResults = [Int]()
        for _ in 0 ..< rollCount {
            let result = Int.random(in: 1 ... sides)
            tempResults.append(result)
        }
        results.append(tempResults)
        print(results)
    }
    
    var resultsString: String {
        results.map(String.init)
            .joined(separator: ", ")
    }
}

struct SettingsView: View {
    @EnvironmentObject var diceRoller: DiceRoller
    @Environment(\.presentationMode) var presentationMode
    let sides = [6, 8, 10, 12, 20]
    @State private var diceSides = 6
    
    var body: some View {
        let diceSidesBinding = Binding<Int>(
            get: { diceSides },
            set: {
                diceRoller.sides = $0
                diceSides = $0
            }
        )
        return NavigationView {
            Form {
                Section(header: Text("Number of sides")) {
                    Picker("Sides", selection: diceSidesBinding) {
                        ForEach(sides, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Times to roll")) {
                    Stepper(
                        onIncrement: { updateRollCount(by: 1) },
                        onDecrement: { updateRollCount(by: -1) },
                        label: {
                            Text("\(diceRoller.rollCount)")
                        }
                    )
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save", action: dismiss))
        }
        .onAppear {
            diceSides = diceRoller.sides
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func updateRollCount(by amount: Int) {
        diceRoller.rollCount += amount
    }
}

struct RollView: View {
    @EnvironmentObject var diceRoller: DiceRoller
    @State private var showingSettings = false
    @Binding var selection: Tab
    
    var body: some View {
        NavigationView {
            VStack {
                Text("rollview \(diceRoller.sides) times: \(diceRoller.rollCount)")
                Button("Roll") {
                    diceRoller.roll()
                }
                Button("Switch to results") {
                    selection = .result
                }
            }
            .navigationBarItems(trailing: Button("Settings") { showingSettings = true })
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }
}

struct ResultsView: View {
    @EnvironmentObject var diceRoller: DiceRoller
    
    var body: some View {
        VStack {
            Text("results view \(diceRoller.sides) times: \(diceRoller.rollCount)")
            List {
                ForEach(diceRoller.results.indices, id: \.self) { rowIndex in
                    Section(header: Text("Roll set #\(rowIndex + 1)")){
                        ForEach(diceRoller.results[rowIndex].indices, id: \.self) { index in
                            Text("Roll #\(index + 1) = \(diceRoller.results[rowIndex][index])")
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
        }
    }
}

enum Tab {
    case roll, result
}

struct ContentView: View {
    var diceRoller = DiceRoller()
    @State private var selectedTab = Tab.roll
    var body: some View {
        TabView(selection: $selectedTab) {
            RollView(selection: $selectedTab)
                .tabItem {
                    Text("Roll")
                }
                .tag(Tab.roll)
            ResultsView()
                .tabItem {
                    Text("Results")
                }
                .tag(Tab.result)
        }
        .environmentObject(diceRoller)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
