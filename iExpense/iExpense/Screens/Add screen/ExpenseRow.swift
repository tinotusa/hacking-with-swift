//
//  ExpenseRow.swift
//  iExpense
//
//  Created by Tino on 20/4/21.
//

import SwiftUI

struct ExpenseRow: View {
    let expense: ExpenseItem

    @EnvironmentObject var expenseTracker: ExpenseTracker
    @State private var showingDeleteIcon = false
    
    var body: some View {
        ZStack {
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
            .gesture(tapGesure)
            
            if showingDeleteIcon {
                deleteButton
            }
        }
    }
    
    var iconTapGesture: some Gesture {
        TapGesture()
            .onEnded {
                withAnimation {
                    expenseTracker.remove(expense)
                }
            }
    }
    
    var tapGesure: some Gesture {
        TapGesture()
            .onEnded {
                showingDeleteIcon.toggle()
            }
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
                    Text("- \(expense.expenseUse!.rawValue)")
                        .font(.subheadline)
                }
            }
            Text(expense.dateAdded, style: .date)
                .font(.subheadline)
        }
    }
    
    var deleteButton: some View {
        VStack {
            HStack {
                Spacer()
                Image("delete icon")
                    .gesture(iconTapGesture)
            }
            Spacer()
        }
    }
}

struct ExpenseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRow(expense: ExpenseItem(amount: 12.34, expenseType: .personal))
    }
}
