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
                CheckBox("Add sprinkes?", isOn: $shoppingCart.cupcakes[index].addSprinkles)
                CheckBox("Add extra frosting?", isOn: $shoppingCart.cupcakes[index].addExtraFrosting)
            }
            .padding(.trailing)
            Spacer()
            Text("\(cupcake.amount)")
        }
        
    }
}

struct CupcakeRow_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeRow(cupcake: Cupcake(name: "rainbow", amount: 2))
            .environmentObject(ShoppingCart())
    }
}
