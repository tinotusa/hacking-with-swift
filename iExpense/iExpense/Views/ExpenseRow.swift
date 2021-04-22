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
            
            VStack(alignment: .leading) {
                Text(expense.expenseType.rawValue.capitalized)
                    .font(.headline)
                Text(expense.dateAdded, style: .date)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text("$\(expense.amount, specifier: "%.2f")")
                .font(.title2)
                
        }
        .padding()
        .foregroundColor(.white)
        .background(Color(expense.expenseType != .savings ? "red" : "green"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 5)
    }
}
struct ExpenseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRow(expense: ExpenseItem(amount: 12.34, expenseType: .personal))
    }
}
