//
//  ContentView.swift
//  iExpense
//
//  Created by Bruce Gilmour on 2021-07-10.
//

import SwiftUI

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: savedItems) {
                items = decoded
                return
            }
        }
        items = []
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            TypeTextView(item.type)
                        }
                        Spacer()
                        AmountTextView(item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
            )
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct TypeTextView: View {
    let type: String

    init(_ type: String) {
        self.type = type
    }

    var body: some View {
        Text(type)
            .foregroundColor(type == "Personal" ? .blue : .purple)
    }
}

struct AmountTextView: View {
    let amount: Int

    init(_ amount: Int) {
        self.amount = amount
    }

    var body: some View {
        var color: Color = .red
        var weight: Font.Weight = .bold
        if amount < 10 {
            color = .black
            weight = .regular
        } else if amount < 100 {
            color = .yellow
            weight = .semibold
        }
        return Text("$\(amount)")
            .foregroundColor(color)
            .fontWeight(weight)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
