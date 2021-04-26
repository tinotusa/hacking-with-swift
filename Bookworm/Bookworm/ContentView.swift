//
//  ContentView.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        Bookshelf()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(
                \.managedObjectContext,
                PersistenceController.shared.container.viewContext
            )
    }
}
