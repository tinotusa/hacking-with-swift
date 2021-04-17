//
//  MainScreen.swift
//  WeSplit
//
//  Created by Tino on 16/4/21.
//

import SwiftUI

struct MainScreen: View {
    @State private var checkTotal = ""
    @State private var numberOfPeople = ""
    @State private var tipAmount = 0
    @State private var test = 0.0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                background
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        RoundedTextField("$0.00", text: $checkTotal)
                            .keyboardType(.decimalPad)
                            .frame(height: proxy.size.height * 0.08)
                            .labeledTextField(title: "Check amount")
                        
                        RoundedTextField("0", text: $numberOfPeople)
                            .keyboardType(.numberPad)
                            .frame(height: proxy.size.height * 0.08)
                            .labeledTextField(title: "Number of people")
                        
                    
                        CustomSlider(range: 0...40, value: $tipAmount)

                        tipOutput
                        
                        Group {
                            TotalCard("Total", text: total)
                            TotalCard("Total per person", text: totalPerPerson)
                        }
                        .frame(height: 150)
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

private extension MainScreen {
    // MARK: - Computed Views
    var background: some View {
        Color("blue")
            .opacity(0.6)
            .ignoresSafeArea()
    }
    
    var tipOutput: some View {
        Group {
            Text("Tip: ")
                .foregroundColor(.white) +
            Text("\(tipAmount)%")
                .foregroundColor(Color("orange"))
        }
        .font(.system(size: 58, weight: .light))
    }
    
    // MARK: - Calculations
    var total: String {
        let total = Double(checkTotal) ?? 0.0
        let tip = Double(tipAmount) / 100.0
        let totalAndTip = total + (total * tip)
        return String(format: "$%.2f", totalAndTip)
    }
    
    var totalPerPerson: String {
        let people = Double(numberOfPeople) ?? 0.0
        if people == 0 { return "$0.00" }
        let total = Double(checkTotal) ?? 0.0
        let tip = Double(tipAmount) / 100.0
        let totalAndTip = total + (total * tip)
        let totalPerPerson = totalAndTip / people
        return String(format: "$%.2f", totalPerPerson)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPhone 12", "iPhone SE (2nd generation)", "iPod touch (2nd generation)"], id: \.self) { deviceName in
                MainScreen()
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
}
