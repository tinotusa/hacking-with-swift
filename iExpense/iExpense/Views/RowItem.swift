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
                Text(item.type)
            }
            Spacer()
            Text("$\(item.amount, specifier: "%.2f")")
        }
    }
}

struct RowItem_Previews: PreviewProvider {
    static var previews: some View {
        RowItem(item: ExpenseItem(name: "test", type: "Business", amount: 12.3))
    }
}
