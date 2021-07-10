//
//  ContentView.swift
//  iExpense
//
//  Created by Bruce Gilmour on 2021-07-10.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Dismiss") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
