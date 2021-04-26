//
//  CupcakeCard.swift
//  CupcakeCorner
//
//  Created by Tino on 25/4/21.
//

import SwiftUI

struct CupcakeCard: View {
    let name: String
    let size: CGFloat = 200
    let radius: CGFloat = 30
    @State private var addToCart = false
    @State private var amount = 0
    @EnvironmentObject var shoppingCart: ShoppingCart
    @State private var cupcake: Cupcake! = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            imageWithLabel
            
            if !addToCart {
                cartButton
                    .floatView()
            } else {
                amountStepper
                    .floatView()
            }
            
        }
        .frame(width: size, height: size)
        .onAppear {
            cupcake = Cupcake(name: name, amount: 0)
        }
    }
}

// MARK: - Computed properties
private extension CupcakeCard {
    var imageWithLabel: some View {
        ZStack(alignment: .bottom) {
            Image(name)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipped()

            HStack {
                Spacer()
                Text(name.capitalized)
                    .font(.system(size: 23))
                    .foregroundColor(.white)
                Spacer()
            }
            .background(Color.black.opacity(0.3))
        }
    }

    var cartButton: some View {
        Button(action: addCupcakeToCart) {
            Image(systemName: "bag")
                .font(.title3)
                .padding(10)
                .foregroundColor(.white)
                .background(Color.gray)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding()
    }
    
    var amountStepper: some View {
        VStack {
            updateButton(label: "+", incrementBy: 1)
            Text("\(amount)")
                .font(.title)
            updateButton(label: "-", incrementBy: -1)
        }
        .padding(.trailing)
    }
    
}

// MARK: - Functions
private extension CupcakeCard {
    func addCupcakeToCart() {
        amount = 1
        addToCart = true
        
        cupcake = Cupcake(name: name, amount: amount)
        shoppingCart.add(cupcake!)
    }
    
    func updateButton(label: String, incrementBy amount: Int) -> some View {
        Button(action: amount > 0 ? increment : decrement) {
            Text(label)
                .font(.title3)
                .padding(10)
                .foregroundColor(.white)
                .background(Color.gray)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
        }
    }
    // don't like the way im updating
    // seems messy and easy forget an update and break something
    func increment() {
        amount += 1
        cupcake.amount = amount
        shoppingCart.update(cupcake!, to: cupcake!)
    }
    
    func decrement() {
        amount -= 1
        if amount <= 0 {
            amount = 0
            addToCart = false
            shoppingCart.remove(cupcake)
            return
        }
        cupcake.amount = amount
        shoppingCart.update(cupcake, to: cupcake)
    }
}

struct CupcakeCard_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeCard(name: "vanilla")
            .environmentObject(ShoppingCart())
    }
}
