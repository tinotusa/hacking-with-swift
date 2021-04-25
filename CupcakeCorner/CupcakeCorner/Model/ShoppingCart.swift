//
//  ShoppingCart.swift
//  CupcakeCorner
//
//  Created by Tino on 25/4/21.
//

import SwiftUI

class ShoppingCart: ObservableObject {
    @Published var cupcakes: [Cupcake] = []
    
    var count: Int {
        cupcakes.count
    }
    
    var isEmpty: Bool {
        cupcakes.isEmpty
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
