//
//  ExpenseTracker.swift
//  iExpense
//
//  Created by Tino on 22/4/21.
//

import Foundation

class ExpenseTracker: ObservableObject, Codable {
    static let saveURL = FileManager.default.documentsURL().appendingPathComponent("expenses.data")
    
    @Published var expenses = [ExpenseItem]()
    @Published var savings: Double = 0
    @Published var spending: Double = 0
    
    init() {
        load()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        expenses = try container.decode([ExpenseItem].self, forKey: .expenses)
        savings = try container.decode(Double.self, forKey: .savings)
        spending = try container.decode(Double.self, forKey: .spending)
    }
}

// MARK:- Functions
extension ExpenseTracker {
    func add(_ expense: ExpenseItem) {
        if expense.expenseType == .savings {
            savings += expense.amount
        } else {
            spending += expense.amount
        }
        expenses.append(expense)
        save()
    }
    
    func remove(atOffsets offsets: IndexSet) {
        for index in offsets {
            expenses.remove(at: index)
        }
        save()
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
        save()
    }
}

// MARK: Load and Save
extension ExpenseTracker {
    
    enum CodingKeys: CodingKey {
        case expenses, savings, spending
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(expenses, forKey: .expenses)
        try container.encode(savings, forKey: .savings)
        try container.encode(spending, forKey: .spending)
    }
    
    func save() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            try data.write(to: Self.saveURL, options: .atomic)
        } catch {
            print("Error saving\n\(error)")
        }
    }
    
    func load() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: Self.saveURL)
            let tempTracker = try decoder.decode(ExpenseTracker.self, from: data)
            expenses = tempTracker.expenses
            spending = tempTracker.spending
            savings = tempTracker.savings
        } catch CocoaError.fileReadNoSuchFile {
            expenses = [ExpenseItem]()
            spending = 0
            savings = 0
        } catch let error as NSError {
            print("Error loading data\n\(error.domain)\n\(error.localizedDescription)")
        }
    }
}
