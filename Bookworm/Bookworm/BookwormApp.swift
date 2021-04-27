//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var imageLoader = ImageLoader()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(imageLoader)
        }
    }
}
