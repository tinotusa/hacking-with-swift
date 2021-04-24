//
//  Cart.swift
//  CupcakeCorner
//
//  Created by Tino on 24/4/21.
//

import SwiftUI

struct CartItem: Codable, Identifiable {
    let id = UUID()
    var name = ""
    var amount = 0
    var extras: [Extra] = []
    
    var specialRequests = false {
        didSet {
            if specialRequests == false {
                extraSprinkles = false
                addSprinkles = false
            }
        }
    }
    var extraSprinkles = false
    var addSprinkles = false
    
    init() {
    }
    
    init(name: String, amount: Int, extras: [Extra] = []) {
        self.name = name
        self.amount = amount
        self.extras = extras
    }
    
    enum CodingKeys: CodingKey {
        case name, amount, extras
    }
    
    
    enum Extra: String, Codable {
        case sprinkles, frosting
    }
}

class Cart: ObservableObject {
    @Published private(set) var items: [CartItem] = []
    
    func add(_ item: CartItem) {
//        if items.contains(where: { $0.name == item.name }) {
//            update(item)
//            return
//        }
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    func remove(_ item: CartItem) {
        let index = indexByName(item)
        items.remove(at: index)
    }
    
    func update(_ item: CartItem, amount: Int) {
        let index = indexByName(item)
        items[index].amount = amount
    }
    
    private func indexByName(_ item: CartItem) -> Int {
        guard let index = items.firstIndex(where: {$0.name == item.name }) else {
            fatalError("Tried to update non existent cart item")
        }
        return index
    }
}
