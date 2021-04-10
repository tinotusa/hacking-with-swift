//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var diceRoller: DiceRoller
    @Environment(\.presentationMode) var presentationMode
    @State private var diceSides: Dice.DiceType = .six
    
    var body: some View {
        let diceSidesBinding = Binding<Dice.DiceType>(
            get: { diceSides },
            set: {
                diceRoller.dice.sides = $0
                diceSides = $0
            }
        )
        return NavigationView {
            Form {
                Section(header: Text("Number of sides")) {
                    Picker("Sides", selection: diceSidesBinding) {
                        ForEach(Dice.DiceType.allCases, id: \.self) { dice in
                            Text("\(dice.rawValue)")
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
            diceSides = diceRoller.dice.sides
        }
    }
}

// MARK: Functions
extension SettingsView {
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func updateRollCount(by amount: Int) {
        diceRoller.rollCount += amount
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
