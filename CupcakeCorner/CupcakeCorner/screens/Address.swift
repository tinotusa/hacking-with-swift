//
//  Address.swift
//  CupcakeCorner
//
//  Created by Tino on 29/3/21.
//

import SwiftUI

struct Address: View {
    @ObservedObject var orderContainer: OrderContainer
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderContainer.order.name)
                TextField("Address", text: $orderContainer.order.streetAddress)
                TextField("City", text: $orderContainer.order.city)
                TextField("Zip code", text: $orderContainer.order.zip)
                    .keyboardType(.numberPad)
            }
            
            Section {
                NavigationLink(destination: Checkout(orderContainer: orderContainer)) {
                    Text("Checkout")
                }
            }
            .disabled(!orderContainer.order.validAddress) // disabled if it doesn't have a valid address
        }
        .navigationBarTitle("Address details")
    }
}

struct Address_Previews: PreviewProvider {
    static var previews: some View {
        Address(orderContainer: OrderContainer())
    }
}
