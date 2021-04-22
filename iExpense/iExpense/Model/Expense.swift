//
//  Expense.swift
//  iExpense
//
//  Created by Tino on 22/4/21.
//

import Foundation

struct ExpenseItem: Codable, Identifiable {
    enum ExpenseType: String, CaseIterable, Identifiable, Codable {
        case savings, personal, business
        var id: ExpenseType { self }
    }
    
    enum Use: String, CaseIterable, Identifiable, Codable {
        case shopping, bills, fuel, rent, etc
        var id: Use { self }
    }
    
    enum CodingKeys: CodingKey {
        case amount, expenseType, expenseUse, dateAdded
    }
    
    var amount: Double
    var expenseType: ExpenseType
    var expenseUse: Use? // might be just a business type
    
    let id = UUID()
    var dateAdded = Date()
}

