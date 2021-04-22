//
//  Home.swift
//  iExpense
//
//  Created by Tino on 20/4/21.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var expenseTracker: ExpenseTracker
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Quote of the day")
                    .font(.headline)
                    Text(quote)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
            }
            .foregroundColor(.white)
            
            Spacer()
            RecentActivity()
        }
        .padding(.horizontal)
    }
    
    var quote: String {
        let index = Int.random(in: 0 ..< quotes.count)
        return quotes[index]
    }
    
    var header: some View {
        HStack {
            VStack {
                Text("Savings")
                Text("$\(expenseTracker.savings, specifier: "%.2f")")
            }
            .foregroundColor(Color("green"))
            Spacer()
            VStack {
                Text("Spending")
                Text("$\(expenseTracker.spending, specifier: "%.2f")")
            }
            .foregroundColor(Color("red"))
        }
        .font(.largeTitle)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(ExpenseTracker())
    }
}
