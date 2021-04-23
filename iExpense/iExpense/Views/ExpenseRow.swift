//
//  ExpenseRow.swift
//  iExpense
//
//  Created by Tino on 20/4/21.
//

import SwiftUI

struct ExpenseRow: View {
    let expense: ExpenseItem
    
    var body: some View {
        HStack {
            expenseIcon
            
            expenseDetails
            
            Spacer()
            
            Text("$\(expense.amount, specifier: "%.2f")")
                .font(.title2)
                
        }
        .padding()
        .foregroundColor(.white)
        .background(color(for: expense.expenseType))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 5)
    }
}

private extension ExpenseRow {
    func color(for expenseType: ExpenseItem.ExpenseType) -> Color {
        Color(expense.expenseType != .savings ? "red" : "green")
    }
    var expenseIcon: some View {
        Group {
            if expense.expenseType == .savings {
                Image("\(expense.expenseType) icon")
            } else {
                Image("\(expense.expenseUse?.rawValue ?? "etc") icon")
                    .resizable()
            }
        }
        .scaledToFit()
        .frame(width: 50, height: 50)
    }
    
    var expenseDetails: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(expense.expenseType.rawValue.capitalized)
                    .font(.headline)
                if expense.expenseUse?.rawValue != nil {
                    Text(" - \(expense.expenseUse!.rawValue)")
                        .font(.subheadline)
                }
            }
            Text(expense.dateAdded, style: .date)
                .font(.subheadline)
        }
    }
}

struct ExpenseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRow(expense: ExpenseItem(amount: 12.34, expenseType: .personal))
    }
}
