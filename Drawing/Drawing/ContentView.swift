//
//  ContentView.swift
//  Drawing
//
//  Created by Tino on 26/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var lineThickness = CGFloat(1)
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 200, height: 200)
            
            Slider(value: $colorCycle)

            Arrow()
                .stroke(style: StrokeStyle(lineWidth: lineThickness, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200)

            Button("Increase") {
                withAnimation(.interpolatingSpring(stiffness: 40, damping: 1)) {
                    lineThickness += 1
                }
            }
        }
        
    }
}

// challenge 3
struct ColorCyclingRectangle: View {
    var amount = 0.0
    let steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0 ..< steps) { index in
                Rectangle()
                    .inset(by: CGFloat(index))
                    .strokeBorder(color(for: index, brightness: 1), lineWidth: 1)
            }
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
    
}

// Challenge 1
struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        let width = CGFloat(rect.width / 4)
        let height = CGFloat(rect.height / 2)
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
        path.addRect(CGRect(x: rect.midX - width / 2, y: rect.midY, width: width, height: height))
        
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
