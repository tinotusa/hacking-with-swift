//
//  OrderView.swift
//  CupcakeCorner
//
//  Created by Tino on 25/4/21.
//

import SwiftUI

struct OrderView: View {
    @State private var confirmedOrder = false
    @EnvironmentObject var orderDetails: OrderDetails
    @EnvironmentObject var shoppingCart: ShoppingCart
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: DeliveryInformation(), isActive: $confirmedOrder) { EmptyView() }
            ScrollView {
                ForEach(shoppingCart.cupcakes) { cupcake in
                    CupcakeRow(cupcake: cupcake)
                }
            }
            Button("Confirm") {
                confirmedOrder = true
            }
            .navigationTitle("Check your order")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(ShoppingCart())
            .environmentObject(OrderDetails())
    }
}
