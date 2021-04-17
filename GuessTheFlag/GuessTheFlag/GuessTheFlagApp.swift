//
//  GuessTheFlagApp.swift
//  GuessTheFlag
//
//  Created by Tino on 4/3/21.
//

import SwiftUI

@main
struct GuessTheFlagApp: App {
    @StateObject var settingsModel = SettingsModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settingsModel)
        }
    }
}
