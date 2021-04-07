//
//  AlertItem.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import Foundation
import SwiftUI

struct AlertItem {
    let id = UUID()
    var title: String
    var message: String?
    var primaryButton: Alert.Button?
    var secondaryButton: Alert.Button?
}

extension AlertItem: Identifiable { }
