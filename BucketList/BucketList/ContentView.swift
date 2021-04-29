//
//  ContentView.swift
//  BucketList
//
//  Created by Tino on 5/4/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    // MARK: - TODO
    // set to false
    @State private var isAuthenticated = true
    var body: some View {
        if isAuthenticated {
            PlacesList()
        } else {
            AuthenticationView(isAuthenticated: $isAuthenticated)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PlacesContainer())
    }
}
