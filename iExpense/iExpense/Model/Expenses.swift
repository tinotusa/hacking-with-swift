//
//  Expenses.swift
//  iExpense
//
//  Created by Tino on 25/3/21.
//

import Foundation


class Expenses: ObservableObject {
    enum ExpenseType: String, CaseIterable, Identifiable {
        var id: ExpenseType {
            self
        }
        case business, personal
    }

    static let itemsKey = "Items"
    
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            let data = try! encoder.encode(items)
            UserDefaults.standard.set(data, forKey: Self.itemsKey)
        }
    }
    
    // init
    init() {
        guard let data = UserDefaults.standard.data(forKey: Self.itemsKey) else {
            items = []
            return
        }
        let decoder = JSONDecoder()
        items = try! decoder.decode([ExpenseItem].self, from: data)
    }
    
    var isEmpty: Bool {
        items.isEmpty
    }
    
    var count: Int {
        items.count
    }
    
    func add(_ item: ExpenseItem) {
        items.append(item)
    }
    
    func removeItems(atOffsets offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
