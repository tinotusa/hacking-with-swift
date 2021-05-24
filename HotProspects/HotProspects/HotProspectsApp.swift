//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Tino on 7/4/21.
//

import SwiftUI

@main
struct HotProspectsApp: App {
    @StateObject var prospects = ProspectList()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(prospects)
        }
    }
}
