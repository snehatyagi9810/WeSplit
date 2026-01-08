//
//  ContentView.swift
//  WeSplit
//
//  Created by Sneha Tyagi on 31/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
   @State private var numberOfPeople = 0
    @State private var tipPercentage = 10
    
    @FocusState private var amountIsFocused: Bool
    
//    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotalAmount / peopleCount
        
        
        return amountPerPerson
    }
    
    var grandTotalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Ampunt", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.automatic)
                }
                Section("How much do you want to tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Grand Total Amount"){
                    Text(grandTotalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                }
                
                Section("Amount Per Person") {
                    Text(totalPerPerson,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
           
        }
      
        
    }
}

#Preview {
    ContentView()
}
