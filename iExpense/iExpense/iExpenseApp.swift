//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Tino on 24/3/21.
//

import SwiftUI

@main
struct iExpenseApp: App {
    @StateObject var expenseTracker = ExpenseTracker()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(expenseTracker)
        }
    }
}
