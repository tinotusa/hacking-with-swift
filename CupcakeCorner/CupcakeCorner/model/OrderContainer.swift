//
//  OrderContainer.swift
//  CupcakeCorner
//
//  Created by Tino on 1/4/21.
//

import Foundation

class OrderContainer: ObservableObject, Codable {
    @Published var order: Order

    init() {
        order = Order()
    }
    
    // MARK: Codable conformance
    enum CodingKeys: CodingKey {
        case order
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order = try container.decode(Order.self, forKey: .order)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
    }
}
