//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Tino on 25/3/21.
//

import Foundation

struct ExpenseItem: Codable, Identifiable {
    let id = UUID()
    let dateAdded = Date()
    let name: String
    let type: String
    let amount: Double
}
