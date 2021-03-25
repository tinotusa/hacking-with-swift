//
//  RowItem.swift
//  iExpense
//
//  Created by Tino on 25/3/21.
//

import SwiftUI

struct RowItem: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type.capitalized)
            }
            Spacer()
            Text("$\(item.amount, specifier: "%.2f")")
                .foregroundColor(amountColor)
        }
    }
    
    var amountColor: Color {
        switch item.amount {
        case ...10: return .green
        case 10 ... 100: return .orange
        default: return .red
        }
    }
}

struct RowItem_Previews: PreviewProvider {
    static var previews: some View {
        RowItem(item: ExpenseItem(name: "test", type: "Business", amount: 12.3))
    }
}
