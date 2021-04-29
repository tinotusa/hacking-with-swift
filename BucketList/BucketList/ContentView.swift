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
    var body: some View {
        if isAuthenticated {
            Text("hello world")
        } else {
            AuthenticationView(isAuthenticated: $isAuthenticated)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
