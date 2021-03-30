//
//  Address.swift
//  CupcakeCorner
//
//  Created by Tino on 29/3/21.
//

import SwiftUI

struct Address: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip code", text: $order.zip)
                    .keyboardType(.numberPad)
            }
            
            Section {
                NavigationLink(destination: Checkout(order: order)) {
                    Text("Checkout")
                }
            }
            .disabled(!order.validAddress) // disabled if it doesn't have a valid address
        }
        .navigationBarTitle("Address details")
    }
}

struct Address_Previews: PreviewProvider {
    static var previews: some View {
        Address(order: Order())
    }
}
