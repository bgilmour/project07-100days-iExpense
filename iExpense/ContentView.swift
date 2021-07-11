//
//  ContentView.swift
//  iExpense
//
//  Created by Bruce Gilmour on 2021-07-10.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var count = 0
    @State private var json = "Uninitialised"

    var body: some View {
        VStack {
            Button("Save User") {
                count += 1
                let user = User(firstName: "Taylor", lastName: "Swift\(count)")
                let encoder = JSONEncoder()

                if let data = try? encoder.encode(user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
            Button("Load Data") {
                if let data = UserDefaults.standard.data(forKey: "UserData") {
                    json = String(decoding: data, as: UTF8.self)
                }
            }
            Text(json)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
