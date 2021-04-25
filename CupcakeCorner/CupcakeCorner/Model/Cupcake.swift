//
//  Cupcake.swift
//  CupcakeCorner
//
//  Created by Tino on 25/4/21.
//

import SwiftUI

struct Cupcake: Codable, Identifiable {
    let id = UUID()
    let name: String
    var amount: Int
    
    var hasSpecialRequest = false {
        didSet {
            if hasSpecialRequest == false {
                addExtraFrosting = false
                addSprinkles = false
            }
        }
    }
    var addExtraFrosting = false
    var addSprinkles = false
    
    var value: Double {
        let costPerCupcake = 1.0
        let costForExtraFrosting = 0.5
        let costForSprinkles = 0.5
        let amount = Double(self.amount)
        
        var total = amount * costPerCupcake
    
        if addExtraFrosting { total += amount * costForExtraFrosting }
        if addSprinkles     { total += amount * costForSprinkles }
        
        return total
    }
    
    enum CodingKeys: CodingKey {
        case name, amount
    }
}
