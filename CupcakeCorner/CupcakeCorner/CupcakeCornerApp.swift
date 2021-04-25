//
//  CupcakeCornerApp.swift
//  CupcakeCorner
//
//  Created by Tino on 29/3/21.
//

import SwiftUI

@main
struct CupcakeCornerApp: App {
    @StateObject var orderDetails = OrderDetails()
    @StateObject var shoppingCart = ShoppingCart()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(orderDetails)
                .environmentObject(shoppingCart)
        }
    }
}
