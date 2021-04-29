//
//  BucketListApp.swift
//  BucketList
//
//  Created by Tino on 5/4/21.
//

import SwiftUI

@main
struct BucketListApp: App {
    @StateObject var places = PlacesContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(places)
        }
    }
}
