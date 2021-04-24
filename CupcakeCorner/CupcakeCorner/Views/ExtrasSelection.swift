//
//  ExtrasSelection.swift
//  CupcakeCorner
//
//  Created by Tino on 24/4/21.
//

import SwiftUI

struct ExtrasSelection: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var item: CartItem
    
    var body: some View {
        VStack {
            Image(item.name)
                .resizable()
                .frame(width: 100, height: 100)
            Form {
                Section(header: Text("Extras")) {
                    Toggle("Special requests", isOn: $item.specialRequests.animation())
                    if item.specialRequests {
                        Toggle("Sprinkles", isOn: $item.addSprinkles)
                        Toggle("Extra frosting", isOn: $item.extraSprinkles)
                    }
                }
                Button("Done", action: dismiss)
            }
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct ExtrasSelection_Previews: PreviewProvider {
    static var previews: some View {
        ExtrasSelection(item: .constant(.init(name: "vanilla", amount: 3)))
            .environmentObject(Cart())
    }
}
