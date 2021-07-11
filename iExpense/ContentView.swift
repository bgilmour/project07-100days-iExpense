//
//  ContentView.swift
//  iExpense
//
//  Created by Bruce Gilmour on 2021-07-10.
//

import SwiftUI

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Int
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var amount = 0

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type).font(.subheadline)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        amount += 5
                        let expense = ExpenseItem(name: "Test", type: "Personal", amount: amount)
                        expenses.items.append(expense)
                    }) {
                        Image(systemName: "plus")
                    }
            )
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
