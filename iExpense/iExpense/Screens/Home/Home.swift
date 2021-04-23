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
        let today = Date()
        let components = Calendar.current.dateComponents(Set<Calendar.Component>(arrayLiteral: .day), from: today)
        let day = components.day ?? 0
        return quotes[day % (quotes.count - 1)]
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
