//
//  RollView.swift
//  DiceRoll
//
//  Created by Tino on 10/4/21.
//

import SwiftUI
import CoreHaptics

struct RollView: View {
    @EnvironmentObject var diceRoller: DiceRoller
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [])
    var rolls: FetchedResults<Roll>
    
    @Binding var selection: Tab
    @State private var showingSettings = false
    @State private var hapticEngine: CHHapticEngine? = nil
    @State private var rollCounter = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sides \(diceRoller.dice.sides.rawValue) times to roll: \(diceRoller.rollCount)")
                Text("total: \(diceRoller.total)")
                Text("result: \(diceRoller.resultsString)")
                Button("Roll") {
                    prepareHaptics()
                    rollCounter += 1
                    diceRoller.roll()
                    addResult()
                    diceRollHaptic()
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
        .onAppear {
            // not rolls.count - 1
            // because I don't want the count to be zero indexed
            rollCounter = rolls.count
        }
    }
}

// MARK: Functions
extension RollView {
    func addResult() {
        let result = Roll(context: viewContext)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(diceRoller.results.last!)
            result.results = data
            result.rolls = Int16(diceRoller.rollCount)
            result.sides = Int16(diceRoller.dice.sides.rawValue)
            result.total = Int16(diceRoller.total)
            result.index = Int16(rollCounter)
        } catch {
            print("Unresolved error \(error.localizedDescription)")
        }
        saveContext()
    }
    
    func saveContext() {
        if !viewContext.hasChanges {
            return
        }
        do {
            try viewContext.save()
        } catch {
            print("Unresolved error: \(error.localizedDescription)")
        }
    }
    
    func prepareHaptics() {
        if !CHHapticEngine.capabilitiesForHardware().supportsHaptics {
            return
        }
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Unresolved error: \(error.localizedDescription)")
        }
    }
    
    func diceRollHaptic() {
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Unresolved error: \(error.localizedDescription)")
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView(selection: .constant(.result))
    }
}
