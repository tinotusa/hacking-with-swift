//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tino on 29/3/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Cake type")) {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0 ..< Order.types.count) { i in
                            Text(Order.types[i])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Stepper(value: $order.quantity, in: 3 ... 20) {
                    Text("Number of cakes: \(order.quantity)")
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: Address(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
