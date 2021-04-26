//
//  CheckBox.swift
//  CupcakeCorner
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct CheckBox: View {
    let label: String
    @Binding var isOn: Bool
    
    init (_ label: String, isOn: Binding<Bool>) {
        self.label = label
        _isOn = isOn
    }
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isOn ? Color.green : Color.gray)
                if isOn {
                    Image(systemName: "checkmark")
                }
            }
            .frame(width: 30, height: 30)
            .onTapGesture {
                isOn.toggle()
            }
        }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox("Some text", isOn: .constant(false))
    }
}
