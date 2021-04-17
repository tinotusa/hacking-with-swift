//
//  CustomStepper.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var value: Int
    let onIncrement: (() -> Void)?
    let onDecrement: (() -> Void)?
    
    init(value: Binding<Int>, onIncrement: (() -> Void)? = nil, onDecrement: (() -> Void)? = nil) {
        _value = value
        self.onIncrement = onIncrement
        self.onDecrement = onDecrement
    }
    
    var body: some View {
        HStack {
            Button(action: decrement) {
                buttonLabel("-")
            }
            
            label
            
            Button(action: increment) {
                buttonLabel("+")
            }
        }
    }
    
    var label: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("gray"), lineWidth: 2)
                .frame(width: 60, height: 60)
            Text("\(value)")
                .font(.custom("Varela Round", size: 30))
                .foregroundColor(Color("pink"))
        }
    }
}

private extension CustomStepper {
    func increment() {
        if let onIncrement = onIncrement {
            onIncrement()
        } else {
            value += 1
        }
    }
    
    func decrement() {
        if let onDecrement = onDecrement {
            onDecrement()
        } else {
            if value == 0 { return }
            value -= 1
        }
    }
    
    func buttonLabel(_ text: String) -> some View {
        ZStack {
            Rectangle()
                .fill(Color("light gray"))
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(text)
                .font(.custom("Varela Round", size: 43))
                .foregroundColor(Color("green"))
        }
    }
}
struct CustomStepper_Previews: PreviewProvider {
    static var previews: some View {
        CustomStepper(value: .constant(2))
    }
}
