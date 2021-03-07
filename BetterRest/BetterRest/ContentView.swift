//
//  ContentView.swift
//  BetterRest
//
//  Created by Tino on 7/3/21.
//

import SwiftUI
import CoreML

struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components)!
    }
    
    let model = try! SleepCalculator(configuration: MLModelConfiguration())
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let vstackSpacing: CGFloat = 0
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: vstackSpacing) {
                    Text("When do you want to wake up?")
                        .headline()
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: vstackSpacing) {
                    Text("Desired amount of sleep")
                        .headline()
                    
                    Stepper(value: $sleepAmount, in: 6 ... 12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                VStack(alignment: .leading, spacing: vstackSpacing) {
                    Text("Daily coffee intake")
                        .headline()
                    
                    Stepper(value: $coffeeAmount, in: 1 ... 20) {
                        Text("\(coffeeAmount) \(pluralize("cup", count: coffeeAmount))")
                    }
                }
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing: Button(action: calculateBedTime) {
                Text("Calculate")
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func calculateBedTime() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let totalSeconds = Double(hour + minute)
            let prediction = try model.prediction(wake: totalSeconds, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = formatter.string(from: sleepTime)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorr, there was a problem calculating your bedtime"
        }
        
        showingAlert = true
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
