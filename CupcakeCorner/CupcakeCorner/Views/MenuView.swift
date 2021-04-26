//
//  MenuView.swift
//  CupcakeCorner
//
//  Created by Tino on 25/4/21.
//

import SwiftUI

struct MenuView: View {
    let cupcakes = ["vanilla", "chocolate", "strawberry", "rainbow"]
    let gridItems: [GridItem] = [GridItem](repeating: .init(.fixed(240)), count: 2)
    @State private var placedOrder = false
    @EnvironmentObject var shoppingCart: ShoppingCart
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                
                NavigationLink(destination: OrderView(), isActive: $placedOrder) { EmptyView() }
                
                VStack {
                    cartIcon
                    
                    LazyHGrid(rows: gridItems) {
                        ForEach(cupcakes, id: \.self) { cupcakeName in
                            CupcakeCard(name: cupcakeName)
                        }
                    }
                    
                    orderButton
                        .disabled(shoppingCart.isEmpty)
                }
            }
        }
    }
}

private extension MenuView {
    var background: some View {
        Color("gray")
    }
    
    var cartIcon: some View {
        HStack {
            Spacer()
            Image(systemName: "cart")
            Text("\(shoppingCart.count)")
        }
        .font(.title3)
        .foregroundColor(.white)
    }
    
    var orderButton: some View {
        HStack {
            Spacer()
            Button(action: placeOrder) {
                Text("Place order")
                    .padding()
                    .foregroundColor(.white)
                    .background(shoppingCart.isEmpty ? Color(.systemGray) : Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            Spacer()
        }
    }
    
    func placeOrder() {
        placedOrder = true
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(OrderDetails())
            .environmentObject(ShoppingCart())
    }
}
