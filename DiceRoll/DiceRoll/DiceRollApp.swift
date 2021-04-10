//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

@main
struct DiceRollApp: App {
    let diceRoller = DiceRoller()
    let persistentController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                    persistentController.container.viewContext
                )
                .environmentObject(diceRoller)
                
        }
    }
}
