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
    @State private var tipAmount = 20
    @State private var test = 0.0
    
    var body: some View {
        ZStack {
            Color("blue")
                .opacity(0.6)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                RoundedTextField("Check amount", text: $checkTotal)
                    .keyboardType(.decimalPad)
                RoundedTextField("# of people", text: $numberOfPeople)
                    .keyboardType(.numberPad)

                CustomSlider(range: 0...40, value: $tipAmount)

                Group {
                    Text("Tip: ")
                        .foregroundColor(.white) +
                    Text("\(tipAmount)%")
                        .foregroundColor(Color("orange"))
                }
                .font(.system(size: 58, weight: .light))
                TotalCard("Total", text: total)
                TotalCard("Total per person", text: totalPerPerson)
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.keyboard)
        
    }
    
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

struct TotalCard: View {
    var header: String
    let text: String
    
    init(_ header: String = "", text: String) {
        self.header = header
        self.text = text
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color("blue")
                VStack(alignment: .center) {
                    Text(header)
                        .foregroundColor(.white)
                    Text(text)
                        .foregroundColor(Color("orange"))
                }
                .font(.system(size: proxy.size.width * 0.1))
            }
            .cornerRadius(20)
            .frame(width: proxy.size.width * 0.90, height: proxy.size.height * 0.4)
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
