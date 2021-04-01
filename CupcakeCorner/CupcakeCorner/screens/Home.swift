//
//  Home.swift
//  CupcakeCorner
//
//  Created by Tino on 1/4/21.
//

import SwiftUI

struct Home: View {
    @ObservedObject var orderContainer: OrderContainer
    
    var body: some View {
        Form {
            Section(header: Text("Cake type")) {
                Picker("Select your cake type", selection: $orderContainer.order.type) {
                    ForEach(0 ..< Order.types.count) { i in
                        Text(Order.types[i])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Stepper(value: $orderContainer.order.quantity, in: 3 ... 20) {
                Text("Number of cakes: \(orderContainer.order.quantity)")
            }
            
            Section {
                Toggle(isOn: $orderContainer.order.specialRequestEnabled.animation()) {
                    Text("Any special requests?")
                }
                if orderContainer.order.specialRequestEnabled {
                    Toggle(isOn: $orderContainer.order.extraFrosting) {
                        Text("Add extra frosting")
                    }
                    
                    Toggle(isOn: $orderContainer.order.addSprinkles) {
                        Text("Add extra sprinkles")
                    }
                }
            }
            
            Section {
                NavigationLink(destination: Address(orderContainer: orderContainer)) {
                    Text("Delivery details")
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(orderContainer: OrderContainer())
    }
}
