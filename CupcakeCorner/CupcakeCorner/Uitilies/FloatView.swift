//
//  FloatView.swift
//  CupcakeCorner
//
//  Created by Tino on 25/4/21.
//

import SwiftUI

struct FloatView: ViewModifier {
    let side: Side
    
    init(to side: Side = .topRight) {
        self.side = side
    }
    
    enum Side {
        case topLeft, topRight, bottomLeft, bottomRight
    }
    
    func body(content: Content) -> some View {
        VStack {
            if side == .bottomLeft || side == .bottomRight {
                Spacer()
            }
            HStack {
                if side == .topLeft || side == .bottomLeft {
                    content
                    Spacer()
                }
                
                if side == .topRight || side == .bottomRight {
                    Spacer()
                    content
                }
            }
            if side == .topLeft || side == .topRight {
                Spacer()
            }
        }
    }
}

extension View {
    func floatView(to side: FloatView.Side = .topRight) -> some View {
        modifier(FloatView(to: side))
    }
}
