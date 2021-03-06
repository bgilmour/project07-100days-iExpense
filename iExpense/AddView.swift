//
//  AddView.swift
//  iExpense
//
//  Created by Bruce Gilmour on 2021-07-11.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode

    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(amount) {
                    let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    showAlert = true
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid amount"),
                      message: Text("Please enter a whole number of dollars for the amount"),
                      dismissButton: .default(Text("OK")) {
                        amount = ""
                      }
                )
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
