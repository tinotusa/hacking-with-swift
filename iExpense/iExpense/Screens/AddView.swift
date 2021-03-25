//
//  Add.swift
//  iExpense
//
//  Created by Tino on 25/3/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = Expenses.ExpenseType.personal
    @State private var amount = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Item name", text: $name)
                HStack {
                    Text("$")
                        .foregroundColor(Color.gray)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Expense type")) {
                    Picker("Expense type", selection: $type) {
                        ForEach(Expenses.ExpenseType.allCases) {
                            Text("\($0.rawValue.capitalized)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button(action: addItem) {
                    Text("Add Item")
                }
                .disabled(formIsEmpty)
            }
            .navigationBarTitle("Add Expense")
            .navigationBarItems(
                trailing:
                    Button(action: addItem) {
                        Text("Add Item")
                    }
            )
        }
    }
    
    var formIsEmpty: Bool {
        name.isEmpty && amount.isEmpty
    }
    
    func addItem() {
        guard !formIsEmpty else { return }
        let amount = Double(self.amount) ?? 0.0
        let item = ExpenseItem(name: name, type: type.rawValue, amount: amount)
        expenses.add(item)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
