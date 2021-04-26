//
//  ShoppingCart.swift
//  CupcakeCorner
//
//  Created by Tino on 25/4/21.
//

import SwiftUI

class ShoppingCart: ObservableObject, Codable {
    @Published var cupcakes: [Cupcake] = []
    
    enum CodingKeys: CodingKey {
        case cupcakes
    }
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cupcakes = try container.decode([Cupcake].self, forKey: .cupcakes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cupcakes, forKey: .cupcakes)
    }
}


extension ShoppingCart {
    var count: Int {
        cupcakes.count
    }
    
    var isEmpty: Bool {
        cupcakes.isEmpty
    }
    
    var cupcakesList: String {
        let entries = cupcakes.map { (cupcake: Cupcake) -> String in
            var listEntry = cupcake.name + " cupcake(s)"
            if cupcake.addExtraFrosting || cupcake.addSprinkles {
                listEntry += " with"
                if cupcake.addSprinkles {
                    listEntry += " sprinkles"
                }
                if cupcake.addExtraFrosting {
                    listEntry += " extra frosting"
                }
            }
            return listEntry
        }
        return ListFormatter.localizedString(byJoining: entries)
    }
    
    func add(_ cupcake: Cupcake) {
        cupcakes.append(cupcake)
    }
    
    func remove(_ cupcake: Cupcake) {
        if let index = cupcakes.firstIndex(where: { $0.name == cupcake.name}) {
            cupcakes.remove(at: index)
        } else {
            fatalError("Tried to remove a non existant item")
        }
    }
    
    func update(_ cupcake: Cupcake, to newCupcake: Cupcake) {
        if let index = getIndex(of: cupcake) {
            if newCupcake.amount == 0 {
                cupcakes.remove(at: index)
            } else {
                cupcakes[index] = newCupcake
            }
        } else {
            fatalError("Tried to update a non existant item")
        }
    }
    
    private func getIndex(of cupcake: Cupcake) -> Int? {
        return cupcakes.firstIndex(where: { $0.name == cupcake.name })
    }
}
