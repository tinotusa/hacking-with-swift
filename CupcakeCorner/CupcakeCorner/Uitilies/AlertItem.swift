//
//  AlertItem.swift
//  CupcakeCorner
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title = ""
    var message: String? = nil
    var dismissButton: Alert.Button? = nil
    
    var item: Alert {
        Alert(
            title: Text(title),
            message: message != nil ? Text(message!) : nil,
            dismissButton: dismissButton ?? Alert.Button.default(Text("OK"))
        )
    }
}
