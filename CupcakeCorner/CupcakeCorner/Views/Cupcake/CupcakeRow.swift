//
//  CupcakeRow.swift
//  CupcakeCorner
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct CupcakeRow: View {
    let cupcake: Cupcake
    @EnvironmentObject var shoppingCart: ShoppingCart
    
    var body: some View {
        HStack {
            Image(cupcake.name)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipped()
                .cornerRadius(20)
                .shadow(radius: 5)

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(cupcake.name.capitalized)
                    Spacer()
                    Text("x \(cupcake.amount)")
                }
                .font(.title3)
                
                Divider()
                CheckBox("Sprinkes?", isOn: $shoppingCart.cupcakes[index].addSprinkles)
                CheckBox("Extra frosting?", isOn: $shoppingCart.cupcakes[index].addExtraFrosting)
            }
            .padding(.trailing)
        }
        .padding()
    }
    
    var index: Int {
        shoppingCart.cupcakes.firstIndex(where: { $0.name == cupcake.name })!
    }
    
}

struct CupcakeRow_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeRow(cupcake: Cupcake(name: "rainbow", amount: 2))
            .environmentObject(ShoppingCart())
    }
}
