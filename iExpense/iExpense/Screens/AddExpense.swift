//
//  AddExpense.swift
//  iExpense
//
//  Created by Tino on 22/4/21.
//

import SwiftUI

struct AddExpense: View {
    @EnvironmentObject var expenseTracker: ExpenseTracker
    @Environment(\.presentationMode) var presentationMode
    
    @State private var amount = ""
    @State private var expenseType: ExpenseItem.ExpenseType = .personal
    @State private var expenseUse: ExpenseItem.Use? = nil
    @State private var invalidAmount = false
    
    var body: some View {
        ZStack {
            Constants.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 40) {
                amountTextField
               
                expenseTypePicker
            
                if expenseType != .savings {
                    usePicker
                }
                
                
                addExpenseButton
            }
            .foregroundColor(Color.white)
            .font(.title3)
            .padding(.horizontal)
            .ignoresSafeArea(.keyboard)
        }
    }
}

// MARK: - Helper properties
private extension AddExpense {
    var usePicker: some View {
        VStack {
            Text("Used for")
            Picker("Used for", selection: $expenseUse) {
                ForEach(ExpenseItem.Use.allCases) { use in
                    Text(use.rawValue.capitalized).tag(use as ExpenseItem.Use?)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .transition(.slide)
    }
    
    var addExpenseButton: some View {
        HStack {
            Spacer()
            Button(action: addExpense) {
                Text("Add Expense")
                    .padding()
                    .background(amount.isEmpty ? Color.red.opacity(0.6) : Color.red)
                    .animation(.easeIn)
            }
            Spacer()
        }
        .disabled(amount.isEmpty)
    }
    
    var amountTextField: some View {
        VStack {
            Text("Amount")
            TextField("Amount", text: $amount)
                .padding(8)
                .keyboardType(.decimalPad)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(invalidAmount ? Color.red : Color.black,
                                lineWidth: invalidAmount ? 4 : 1)
                        .animation(Animation.default)
                )
                .foregroundColor(.black)
        }
    }
    
    var expenseTypePicker: some View {
        VStack {
            Text("Expense type")
            Picker("Expense type", selection: $expenseType.animation()) {
                ForEach(ExpenseItem.ExpenseType.allCases) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

// MARK: - Functions
private extension AddExpense {
    func addExpense() {
        guard let amount = Double(self.amount) else {
            invalidAmount = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                invalidAmount = false
            }
            return
        }
        
        let expense = ExpenseItem(
            amount: amount,
            expenseType: expenseType,
            expenseUse: expenseUse,
            dateAdded: Date()
        )
        expenseTracker.add(expense)
        expenseTracker.save()
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense()
            .environmentObject(ExpenseTracker())
    }
}
