//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Tino on 8/4/21.
//

import SwiftUI

@main
struct FlashzillaApp: App {
    @StateObject var userData = UserData()
    @StateObject var settingsData = SettingsData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
                .environmentObject(settingsData)
        }
    }
}
