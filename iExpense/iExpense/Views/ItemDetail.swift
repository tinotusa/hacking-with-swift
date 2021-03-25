//
//  ItemDetail.swift
//  iExpense
//
//  Created by Tino on 25/3/21.
//

import SwiftUI

struct ItemDetail: View {
    let item: ExpenseItem
    
    var body: some View {
        NavigationView {
            Form {
                Text("Cost: $ ") +
                Text("\(item.amount, specifier: "%.2f")")
                    .foregroundColor(amountColor)
                Text("Type: \(item.type)")
                Text("Added: \(formattedDate)")
            }
            .navigationBarTitle("Details for \(item.name)")
        }
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: item.dateAdded)
    }
    
    var amountColor: Color {
        switch item.amount {
        case ...10: return .green
        case 10 ... 100: return .orange
        default: return .red
        }
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail(item: ExpenseItem(name: "test", type: "Personal", amount: 24.4))
    }
}
