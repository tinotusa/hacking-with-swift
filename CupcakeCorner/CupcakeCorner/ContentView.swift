//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tino on 29/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        OrderSelection()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Cart())
    }
}
