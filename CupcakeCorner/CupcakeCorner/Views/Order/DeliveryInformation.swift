//
//  DeliveryInformation.swift
//  CupcakeCorner
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct DeliveryInformation: View {
    @EnvironmentObject var orderDetails: OrderDetails
    @EnvironmentObject var shoppingCart: ShoppingCart
    @State private var alertItem: AlertItem? = nil

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderDetails.name)
                TextField("address", text: $orderDetails.address)
            }
            Section {
                TextField("Any notes for us?", text: $orderDetails.notes)
            }
            Button("Place order", action: placeOrder)
                .disabled(!allFormsFilled)
        }
        .navigationTitle("Delivery Details")
        .alert(item: $alertItem) { alert in
            alert.item
        }
    }
}

private extension DeliveryInformation {
    var allFormsFilled: Bool {
        let name = orderDetails.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let address = orderDetails.address.trimmingCharacters(in: .whitespacesAndNewlines)
        return !name.isEmpty && !address.isEmpty
    }
    
    func placeOrder() {
        orderDetails.shoppingCart = shoppingCart
        let encoder = JSONEncoder()        
        do {
            let data = try encoder.encode(orderDetails)
            NetworkManager.sendOrder(data: data, completion: showResult)
        } catch {
            print("Error encoding: \(error.localizedDescription)")
        }
    }
    
    func showResult(result: Result<OrderDetails, NetworkError>) {
        switch result {
        case .success(let order):
            alertItem = AlertItem(
                title: "Order recieved",
                message: "For: \(order.name)\nAt: \(order.address)\nOrder: \(order.shoppingCart.cupcakesList)"
            )
        case .failure(let error):
            switch error {
            case .error(let error):
                alertItem = AlertItem(
                    title: "Error",
                    message: "\(error.localizedDescription)")
            case .serverError(let response):
                alertItem = AlertItem(
                    title: "Server error",
                    message: "Status: \(response.statusCode)"
                )
            case .decodingError(let error):
                alertItem = AlertItem(
                    title: "Decoding error",
                    message: "\(error.localizedDescription)")
            }
        }
    }
}

struct DeliveryInformation_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryInformation()
            .environmentObject(ShoppingCart())
            .environmentObject(OrderDetails())
    }
}
