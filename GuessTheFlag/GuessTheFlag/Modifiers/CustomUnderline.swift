//
//  CustomUnderline.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import SwiftUI

struct CustomUnderline: ViewModifier {
    let underlineHeight = CGFloat(3)
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color.white)
                .frame(height: underlineHeight)
            content
                .offset(y: underlineHeight)
        }
    }
}

extension View {
    func customUnderline() -> some View {
        modifier(CustomUnderline())
    }
}
