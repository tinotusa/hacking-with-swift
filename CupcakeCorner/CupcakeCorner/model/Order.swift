//
//  Order.swift
//  CupcakeCorner
//
//  Created by Tino on 29/3/21.
//

import Foundation

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var cost: Double {
        let quantity = Double(self.quantity)
        var total = quantity * 2
        total += Double(type) / 2
        
        if extraFrosting {
            total += quantity
        }
        if addSprinkles {
            total += quantity / 2
        }
        return total
    }
    
    // delivery details
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var validAddress: Bool {
        let name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let streetAddress = self.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let city = self.city.trimmingCharacters(in: .whitespacesAndNewlines)
        let zip = self.zip.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return !(name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty)
    }
}
