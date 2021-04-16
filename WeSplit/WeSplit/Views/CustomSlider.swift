//
//  CustomSlider.swift
//  WeSplit
//
//  Created by Tino on 16/4/21.
//

import SwiftUI

struct CustomSlider: View {
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    let range: ClosedRange<Int>
    @Binding var value: Int
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .fill(Color("slider"))
                    .frame(width: proxyWidth(proxy), height: 10)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Circle()
                    .fill(Color("orange"))
                    .frame(width: 30, height: 30)
                    .offset(x: currentPosition.width)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let width = clamp(value.translation.width + newPosition.width,
                                                  from: -proxyWidth(proxy) / 2, to: proxyWidth(proxy) / 2)
                                setValue(width: width, proxy: proxy)
                                currentPosition = CGSize(width: width, height: 0)
                            }
                            .onEnded { value in
                                let width = clamp(value.translation.width + newPosition.width,
                                                  from: -proxyWidth(proxy) / 2, to: proxyWidth(proxy) / 2)
                                setValue(width: width, proxy: proxy)
                                currentPosition = CGSize(width: width, height: 0)
                                newPosition = currentPosition
                            }
                    )
            }
        }
        .frame(maxHeight: 30)
    }
    
    func proxyWidth(_ proxy: GeometryProxy) -> CGFloat {
        proxy.size.width
    }
    
    private func setValue(width: CGFloat, proxy: GeometryProxy) {
        let width = Int(width) + Int(proxyWidth(proxy)) / 2
        let maxAllowed = range.last!
        let minAllowed = range.first!
        let minRange = 0
        let maxRange = Int(proxyWidth(proxy))
        value = (maxAllowed - minAllowed) * (width - minRange) / (maxRange - minRange) + minAllowed
    }
    
    func clamp<T: Numeric>(_ value: T, from min: T, to max: T) -> T
        where T: Comparable
    {
        if value < min {
            return min
        } else if value > max {
            return max
        }
        return value
    }
}
struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(range: 1...10, value: .constant(2))
    }
}
