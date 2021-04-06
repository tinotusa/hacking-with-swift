//
//  AlertItem.swift
//  BucketList
//
//  Created by Tino on 6/4/21.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: String
    var message: String?
    var primaryButton: Alert.Button?
    var secondaryButton: Alert.Button?
}
