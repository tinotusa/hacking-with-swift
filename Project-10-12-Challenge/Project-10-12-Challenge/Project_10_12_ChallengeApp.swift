//
//  Project_10_12_ChallengeApp.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 4/4/21.
//

import SwiftUI

@main
struct Project_10_12_ChallengeApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     persistenceController.container.viewContext
                )
        }
    }
}
