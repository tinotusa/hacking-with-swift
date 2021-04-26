//
//  OrderDetails.swift
//  CupcakeCorner
//
//  Created by Tino on 25/4/21.
//

import SwiftUI

class OrderDetails: ObservableObject, Codable {
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var notes: String = ""
    var shoppingCart: ShoppingCart = ShoppingCart()
    
    init() {
    }
    
    enum CodingKeys: CodingKey {
        case name, address, notes, shoppingCart
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        notes = try container.decode(String.self, forKey: .notes)
        shoppingCart = try container.decode(ShoppingCart.self, forKey: .shoppingCart)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(notes, forKey: .notes)
        try container.encode(shoppingCart, forKey: .shoppingCart)
    }
}
