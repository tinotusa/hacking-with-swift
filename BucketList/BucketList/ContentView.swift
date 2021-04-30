//
//  ContentView.swift
//  BucketList
//
//  Created by Tino on 5/4/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var isAuthenticated = false
    //  get url from somewhere
    private let url = URL(string: "https://www.australia.com/content/australia/en/places/sydney-and-surrounds/guide-to-sydney/jcr:content/hero/desktop.adapt.1920.high.jpg")!
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
