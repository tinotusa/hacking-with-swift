//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tino on 29/3/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var orderContainer = OrderContainer()
    
    var body: some View {
        NavigationView {
            Home(orderContainer: orderContainer)
                .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
