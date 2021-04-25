//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tino on 29/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MenuView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(OrderDetails())
            .environmentObject(ShoppingCart())
    }
}
