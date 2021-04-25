//
//  OrderDetails.swift
//  CupcakeCorner
//
//  Created by Tino on 25/4/21.
//

import SwiftUI

class OrderDetails: ObservableObject {
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var notes: String = ""
}
