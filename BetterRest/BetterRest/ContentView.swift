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
    
    var sleepTime: String {
        calculateBedTime()
    }
    
    let vstackSpacing: CGFloat = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 6 ... 12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake")) {
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(1 ..< 21) { cup in
                            Text("\(cup) \(pluralize("cup", count: cup))")
                        }
                    }
                }
                
                Section(header: Text("Sleep time")) {
                    HStack {
                        Spacer()
                        Text(sleepTime)
                            .font(.largeTitle)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    func calculateBedTime() -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let totalSeconds = Double(hour + minute)
            let prediction = try model.prediction(wake: totalSeconds, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            return formatter.string(from: sleepTime)
        } catch {
            print(error)
        }
        return "Error, try again."
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
