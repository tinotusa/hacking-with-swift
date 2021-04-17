//
//  CustomToggle.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import SwiftUI



struct CustomToggle: View {
    @Binding var isOn: Bool
    
    let circleSize = CGFloat(30)
    let onColor = Color("green")
    let offColor = Color("gray")
    let toggleWidth = CGFloat(50)
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color("light gray"))
                .frame(width: toggleWidth, height: 20)
                .cornerRadius(40)
            
            Circle()
                .fill(isOn ? onColor : offColor)
                .offset(x: isOn ? toggleWidth - circleSize: 0)
                .frame(width: circleSize, height: circleSize)
        }
        .onTapGesture {
            withAnimation {
                isOn.toggle()
            }
        }
    }
}

struct CustomToggle_Previews: PreviewProvider {
    static var previews: some View {
        CustomToggle(isOn: .constant(false))
    }
}
