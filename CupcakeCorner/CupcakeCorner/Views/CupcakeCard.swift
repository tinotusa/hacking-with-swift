//
//  CupcakeCard.swift
//  CupcakeCorner
//
//  Created by Tino on 24/4/21.
//

import SwiftUI

struct CupcakeCard: View {
    let cupcake: String
    let size: CGFloat = 100

    @State private var isInCart = false
    @State private var count = 0
    @State private var showingExtras = false
    @EnvironmentObject var cart: Cart
    
    @State private var item: CartItem = CartItem()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Image(cupcake)
                    .resizable()
                    .frame(width: size, height: size)
                
                    Text(cupcake.capitalized)
                HStack {
                    if !isInCart {
                        Text("Add to cart")
                            .onTapGesture(perform: addToCart)
                    } else {
                        Button(action: increment) {
                            Text("+")
                        }
                        Text("\(count)")
                        Button(action: decrement) {
                            Text("-")
                        }
                    }
                }
            }
            if count > 0 {
                optionsButton
            }
        }
//        .border(Color.black)
//        .frame(width: 200, height: 200)
        .sheet(isPresented: $showingExtras) {
            ExtrasSelection(item: $item)
        }
    }
}

private extension CupcakeCard {
    var optionsButton: some View {
        VStack {
            HStack {
                Spacer()
                Text("Options")
                    .padding(5)
                    .background(Color.pink.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    
            }
            Spacer()
        }
        .onTapGesture(perform: showExtras)
    }
}

// TODO
// check to see if you can dup items
private extension CupcakeCard {
    func addToCart() {
        isInCart = true
        count = 1
        item = CartItem(name: cupcake, amount: count)
        cart.add(item)
    }
    
    func increment() {
        count += 1
        cart.update(item, amount: count)
    }
    
    func decrement() {
        count -= 1
        if count <= 0 {
            isInCart = false
            count = 0
            cart.remove(item)
            return
        }
        cart.update(item, amount: count)
    }
    
    func showExtras() {
        showingExtras = true
    }
}

struct CupcakeCard_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeCard(cupcake: "vanilla")
            .environmentObject(Cart())
    }
}
