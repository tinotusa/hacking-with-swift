//
//  FloatView.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI

struct FloatView: ViewModifier {
    var side: Side
    
    init(to side: Side = .bottomRight) {
        self.side = side
    }
    
    enum Side {
        case topLeft, topRight
        case bottomLeft, bottomRight
        case topCenter, center
    }
    
    func body(content: Content) -> some View {
        VStack {
            if side == .bottomLeft || side == .bottomRight || side == .center {
                Spacer()
            }
            HStack {
                if side == .center || side == .topCenter {
                    Spacer()
                    content
                    Spacer()
                }
                if side == .topLeft || side == .bottomLeft {
                    content
                    Spacer()
                } else if side == .topRight || side == .bottomRight {
                    Spacer()
                    content
                }
            }
            if side == .topLeft || side == .topRight || side == .center || side == .topCenter {
                Spacer()
            }
        }
    }
}


extension View {
    func floatView(to side: FloatView.Side = .bottomRight) -> some View {
        modifier(FloatView(to: side))
    }
}
