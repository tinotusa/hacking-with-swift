//
//  SnowSeekerApp.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

@main
struct SnowSeekerApp: App {
    @StateObject private var favourites = Favourites()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favourites)
        }
    }
}
