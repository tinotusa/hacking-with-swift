//
//  ContentView.swift
//  WeSplit
//
//  Created by Tino on 3/3/21.
//

import SwiftUI

struct ContentView: View {
    let tipPercentages: [Double] = [10, 15, 20, 25, 0]
    
    @State private var checkAmount = ""
    @State private var tipPercentageIndex = 2
    @State private var numberOfPeople = "2"
    
    var totalPerPerson: Double {
        guard let checkAmount = Double(self.checkAmount) else {
            return 0
        }
        let tipPercentage = tipPercentages[tipPercentageIndex] / 100.0
        let numberOfPeople = Double(self.numberOfPeople) ?? 0 + 2
        
        let grandTotal = checkAmount + (checkAmount * tipPercentage)
        if grandTotal <= 0 {
            return 0
        }
        
        let amountPerPerson = grandTotal / numberOfPeople

        return amountPerPerson
    }
    
    var total: Double {
        totalPerPerson * (Double(numberOfPeople) ?? 0 + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("$")
                        TextField("Check amount", text: $checkAmount)
                            .keyboardType(.decimalPad)
                    }
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentageIndex) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0], specifier: "%g")%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Amount per person")) {
                    Text("$ \(totalPerPerson, specifier: "%.2f")")
                }
                Section(header: Text("Total amount")) {
                    Text("$ \(total, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
