//
//  Expenses.swift
//  iExpense
//
//  Created by Tino on 25/3/21.
//

import Foundation


class Expenses: ObservableObject {
    static let itemsKey = "Items"
    
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            let data = try! encoder.encode(items)
            UserDefaults.standard.set(data, forKey: Self.itemsKey)
        }
    }
    
    init() {
        guard let data = UserDefaults.standard.data(forKey: Self.itemsKey) else {
            items = []
            return
        }
        let decoder = JSONDecoder()
        items = try! decoder.decode([ExpenseItem].self, from: data)
    }
    // MARK: Computed properties
    var isEmpty: Bool {
        items.isEmpty
    }
    
    var count: Int {
        items.count
    }
    // MARK: Functions
    func add(_ item: ExpenseItem) {
        items.append(item)
    }
    
    func removeItems(atOffsets offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    // MARK: Helper type
    enum ExpenseType: String, CaseIterable, Identifiable {
        var id: ExpenseType {
            self
        }
        case business, personal
    }
}
