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
    @State private var coffeeAmount = ""
    @State private var isEditing = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                background
                    .ignoresSafeArea()
                Text("Picture by: Casey Horner")
                    .whiteTitleFont()
                    .opacity(0.1)
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer(minLength: proxy.size.height * 0.1)
                        Group {
                            Text("When do you want\n") +
                            Text("to wake up?")
                        }
                        .whiteTitleFont()
                        DatePicker("Wake up", selection: $wakeUp, displayedComponents: [.hourAndMinute])
                            .labelsHidden()
                        
                        Group {
                            Text("How much sleep\n") +
                            Text("would you like to get?")
                        }
                        .whiteTitleFont()
                        
                        hoursStepper
                            
                        Text("Daily coffee intake:")
                            .whiteTitleFont()
                        cupPicker
                        
                        Text("Calculated sleep time:")
                            .whiteTitleFont()
                        Text("\(sleepTime)")
                            .foregroundColor(.orange)
                            .font(.title)
                    }
                    .multilineTextAlignment(.center)
                }
            }
            .frame(width: proxy.size.width)
        }
    }
}

private extension ContentView {
    var background: some View {
        ZStack(alignment: .bottom) {
            Image("nightsky")
                .resizable()
                .scaledToFill()
            
            Rectangle()
                .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                        startPoint: .top,
                        endPoint: .bottom)
                )
        }
    }
    
    
    var hoursStepper: some View {
        ZStack {
            Rectangle().fill(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            HStack {
                Text("\(sleepAmount, specifier: "%g") hours")
                    .foregroundColor(.gray)
                Spacer()
                Stepper("Sleep amount", value: $sleepAmount)
                    .labelsHidden()
            }
            .padding(.horizontal)
        }
        .frame(width: 220, height: 45)
    }

    var cupPicker: some View {
        ZStack {
            Rectangle().fill(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            TextField("Cups", text: $coffeeAmount)
                .keyboardType(.numberPad)
        }
        .frame(width: 220, height: 45)
    }
    
    var sleepTime: String {
        calculateBedTime()
    }
    
    func calculateBedTime() -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        let coffeeAmount = Double(self.coffeeAmount) ?? 0
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
}

struct WhiteTitleFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.white)
    }
}

extension View {
    func whiteTitleFont() -> some View {
        modifier(WhiteTitleFont())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        ForEach(["iPhone 12", "iPod touch (7th generation)", "iPhone SE (2nd generation)"], id: \.self) { deviceName in
//            ContentView()
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//        }
    }
}
