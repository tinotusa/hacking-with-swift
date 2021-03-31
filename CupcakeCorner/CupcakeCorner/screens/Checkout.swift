//
//  Checkout.swift
//  CupcakeCorner
//
//  Created by Tino on 30/3/21.
//

import SwiftUI

struct Checkout: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text("Your total is $\(order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        NetworkManager.placeOrder(order: order) { result in
                            switch result {
                            case .success(let order):
                                alertTitle = "Order complete"
                                confirmationMessage = """
                                    Your order has been placed.
                                    \(order.quantity) x \(Order.types[order.type].capitalized) cupcakes
                                    """
                                print(order.name)
                            case .failure(let error):
                                alertTitle = "Error"
                                switch error {
                                case .noConnection:
                                    confirmationMessage = "No internet connection, your order has not been placed."
                                default:
                                    confirmationMessage = "An error occured, your order has not been placed.\n\(error.localizedDescription)"
                                }
                                print(error)
                            }
                            showingAlert = true
                        }
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(confirmationMessage),
                dismissButton:
                    .default(Text("OK"))
                )
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }
}

struct Checkout_Previews: PreviewProvider {
    static var previews: some View {
        Checkout(order: Order())
    }
}
