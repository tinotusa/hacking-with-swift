//
//  OrderSelection.swift
//  CupcakeCorner
//
//  Created by Tino on 24/4/21.
//

import SwiftUI

struct OrderSelection: View {
    let gridItems = [GridItem](repeating: .init(.fixed(200)), count: 2)
    let cupcakes = ["vanilla", "chocolate", "strawberry", "rainbow"]
    @EnvironmentObject var cart: Cart
    @State private var showingCart = false
    
    var body: some View {
        ZStack {
            background
            
            VStack {
                HStack {
                    Text("Cupcake Corner")
                        .font(.largeTitle)
                    Spacer()
                    HStack {
                        Image(systemName: "cart")
                        Text("\(cart.count)")
                    }
                    .onTapGesture(perform: showCart)
                }
                ScrollView {
                    LazyVGrid(columns: gridItems) {
                        ForEach(cupcakes, id: \.self) { cupcake in
                            CupcakeCard(cupcake: cupcake)
                                .padding()
                        }
                    }
                }
                Spacer()
            }
            .padding()
            
//            if showingCart {
            VStack {
                HStack {
                    Image(systemName: "cart")
                    Text("\(cart.count)")
                }
                .onTapGesture(perform: showCart)
                Rectangle()
                    .frame(width: 200)
                    .offset(x: showingCart ? 100 : 350)
                    .animation(.default)
            }
        }
    }
}

private extension OrderSelection {
    var background: some View {
        Color.white
            .ignoresSafeArea()
    }
    
    func showCart() {
        showingCart.toggle()
    }
}
struct OrderSelection_Previews: PreviewProvider {
    static var previews: some View {
        OrderSelection()
            .environmentObject(Cart())
    }
}
