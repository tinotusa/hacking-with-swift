//
//  FloatView.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

struct FloatView: ViewModifier {
    let side: Side
    
    init(to side: Side = .topRight) {
        self.side = side
    }
    
    func body(content: Content) -> some View {
        VStack {
            if side == .bottomLeft || side == .bottomRight || side == .center {
                Spacer()
            }
            HStack {
                if side == .center {
                    Spacer()
                    content
                    Spacer()
                } else if side == .topLeft {
                    content
                    Spacer()
                } else if side ==  .topRight {
                    Spacer()
                    content
                }
            }
            if side == .topLeft || side == .topRight || side == .center {
                Spacer()
            }
        }
            
    }
    
    enum Side {
        case topLeft, topRight
        case bottomLeft, bottomRight
        case center
    }
}

extension View {
    func floatView(to side: FloatView.Side = .topRight) -> some View {
        modifier(FloatView(to: side))
    }
}
