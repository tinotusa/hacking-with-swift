//
//  ContentView.swift
//  BetterRest
//
//  Created by Tino on 7/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                    .headline()
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired amount of sleep")
                    .headline()
                
                Stepper(value: $sleepAmount, in: 6 ... 12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
                
                Text("Daily coffee intake")
                    .headline()
                
                Stepper(value: $coffeeAmount, in: 1 ... 20) {
                    Text("\(coffeeAmount) \(pluralize("cup", count: coffeeAmount))")
                }
            }
            .padding()
            .navigationBarTitle("BetterRest")
        }
    }
    
    func pluralize(_ text: String, count: Int) -> String {
        if count == 1 {
            return text
        }
        return text + "s"
    }
    
}

struct HeadLine: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
    }
}

extension View {
    func headline() -> some View {
        self.modifier(HeadLine())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
