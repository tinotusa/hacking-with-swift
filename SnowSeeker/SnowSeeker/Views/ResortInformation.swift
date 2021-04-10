//
//  ResortInformation.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

struct ResortInformation: View {
    let resort: Resort
    var body: some View {
        Group {
            Text("Size: \(size)")
            Spacer().frame(height: 0)
            Text("Price: \(price)")
        }
    }
}

extension ResortInformation {
    var size: String {
        switch resort.size {
        case 1: return "Small"
        case 2: return "Average"
        default: return "Large"
        }
    }
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
}

struct ResortInformation_Previews: PreviewProvider {
    static var previews: some View {
        ResortInformation(resort: Resort.example)
    }
}
