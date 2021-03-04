//
//  ContentView.swift
//  UnitConverter
//
//  Created by Tino on 4/3/21.
//

import SwiftUI

struct ContentView: View {
    enum Unit: String, CaseIterable, Identifiable {
        var id: Unit { self }
        case celsius, fahrenheit, kelvin
    }
    
    @State private var unitInput = Unit.celsius
    @State private var unitOutput = Unit.fahrenheit
    @State private var temperature = ""
    
    var convertedTemperature: Double {
        let temperature = Double(self.temperature) ?? 0
        if unitInput == unitOutput {
            return temperature
        }
        var convertedTemperature = 0.0
        
        switch unitInput {
        case .celsius:
            switch unitOutput {
            case .fahrenheit:
                convertedTemperature = temperature * 1.8 + 32
            case .kelvin:
                convertedTemperature = temperature + 273.15
            default:
                break // the case where the units are the same is handled above
            }
        case .fahrenheit:
            switch unitOutput {
            case .celsius:
                convertedTemperature = (temperature - 32) / 1.8
            case .kelvin:
                convertedTemperature = (temperature - 32) / 1.8 + 273.15
            default:
                break
            }
        case .kelvin:
            switch unitOutput {
            case .celsius:
                convertedTemperature = temperature - 273.15
            case .fahrenheit:
                convertedTemperature = temperature * 1.8 - 459.67
            default:
                break
            }
        }
        return convertedTemperature
    }
    
    var validInput: Bool {
        !temperature.isEmpty && Double(temperature) != nil
    }
    
    func unitSymbol(for unit: Unit) -> String {
        switch unit {
        case .celsius:
            return "℃"
        case .fahrenheit:
            return "℉"
        case .kelvin:
            return "K"
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Temperature", text: $temperature)
                    .keyboardType(.decimalPad)
                
                Section(header: Text("From")) {
                    Picker("Unit input", selection: $unitInput) {
                        ForEach(Unit.allCases) {
                            Text("\($0.rawValue.capitalized)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To")) {
                    Picker("Output unit", selection: $unitOutput) {
                        ForEach(Unit.allCases) {
                            Text("\($0.rawValue.capitalized)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    if !validInput {
                        Text("Enter a temperature above")
                            .foregroundColor(.gray)
                    } else {
                        Text("\(convertedTemperature, specifier: "%g") \(unitSymbol(for: unitOutput))")
                    }
                }
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
