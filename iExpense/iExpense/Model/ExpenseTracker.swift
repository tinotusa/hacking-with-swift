//
//  ExpenseTracker.swift
//  iExpense
//
//  Created by Tino on 22/4/21.
//

import Foundation

class ExpenseTracker: ObservableObject {
    @Published var expenses = [ExpenseItem]()
    @Published var savings: Double = 0
    @Published var spending: Double = 0
    
    func add(_ expense: ExpenseItem) {
        if expense.expenseType == .savings {
            savings += expense.amount
        } else {
            spending += expense.amount
        }
        expenses.append(expense)
    }
    
    func update(expense: ExpenseItem, to newItem: ExpenseItem) {
        guard let index = expenses.firstIndex(where: { $0.id == expense.id }) else {
            fatalError("Tried to update non-existent expense item")
        }
        expenses[index] = newItem
    }
    
    func remove(_ expense: ExpenseItem) {
        guard let index = expenses.firstIndex(where: {$0.id == expense.id }) else {
            fatalError("Tried to remove expense that didn't exist")
        }
        
        let expense = expenses[index]
        if expense.expenseType == .savings {
            savings -= expense.amount
        } else {
            spending -= expense.amount
        }

        expenses.remove(at: index)
    }
}
