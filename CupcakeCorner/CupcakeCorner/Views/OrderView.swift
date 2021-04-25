//
//  OrderView.swift
//  CupcakeCorner
//
//  Created by Tino on 25/4/21.
//

import SwiftUI


struct CupcakeRow: View {
    let cupcake: Cupcake
    @EnvironmentObject var shoppingCart: ShoppingCart
    
    var index: Int {
        shoppingCart.cupcakes.firstIndex(where: { $0.name == cupcake.name })!
    }
    
    var body: some View {
        HStack {
            Image(cupcake.name)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
            VStack {
                Text(cupcake.name)
                Toggle("Add sprinkes?", isOn: $shoppingCart.cupcakes[index].addSprinkles)
                Toggle("Add extra frosting?", isOn: $shoppingCart.cupcakes[index].addExtraFrosting)
            }
            Spacer()
            Text("\(cupcake.amount)")
        }
        
    }
}

struct OrderView: View {
    @State private var confirmedOrder = false
    @EnvironmentObject var orderDetails: OrderDetails
    @EnvironmentObject var shoppingCart: ShoppingCart
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Please check your order")
            ScrollView {
                ForEach(shoppingCart.cupcakes) { cupcake in
                    CupcakeRow(cupcake: cupcake)
                }
            }
            Button("Confirm") {
                confirmedOrder = true
            }
        }
        .sheet(isPresented: $confirmedOrder) {
            Form {
                Section {
                    TextField("Name", text: $orderDetails.name)
                    TextField("address", text: $orderDetails.address)
                }
                Section {
                    TextField("Any notes for us?", text: $orderDetails.notes)
                }
                Button("Place order") {
                    
                }
            }
            .background(Color.black)
        }
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(OrderDetails())
    }
}
