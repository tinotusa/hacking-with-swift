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

    @State private var showError = false
    
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
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"),
                      message: Text("Invalid input (amount must be a number)"),
                      dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    var formIsEmpty: Bool {
        name.isEmpty && amount.isEmpty
    }
    
    func addItem() {
        guard !formIsEmpty else { return }
        guard let amount = Double(self.amount) else {
            showError = true
            return
        }
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
