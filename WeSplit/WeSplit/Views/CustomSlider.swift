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
    
    let knobSize = CGFloat(30)
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color("slider"))
                    .frame(height: knobSize * (1 / 3.0))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Circle()
                    .fill(Color("orange"))
                    .frame(width: knobSize, height: knobSize)
                    .offset(x: currentPosition.width)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                updateCurrentPosition(dragValue: value, proxy: proxy)
                                setValue(proxy: proxy)
                            }
                            .onEnded { value in
                                updateCurrentPosition(dragValue: value, proxy: proxy)
                                setValue(proxy: proxy)
                                newPosition = currentPosition
                            }
                    )
            }
        }
        .frame(maxHeight: knobSize)
    }
}

private extension CustomSlider {
    func updateCurrentPosition(dragValue value: DragGesture.Value, proxy: GeometryProxy) {
        let width = clamp(value.translation.width + newPosition.width,
                          from: 0, to: maxWidth(proxy))
        currentPosition = CGSize(width: width, height: 0)
    }
    
    func maxWidth(_ proxy: GeometryProxy) -> CGFloat {
        proxy.size.width - knobSize
    }
    
    func setValue(proxy: GeometryProxy) {
        let width = Int(currentPosition.width)
        let minAllowed = range.first!
        let maxAllowed = range.last!
        let minRange = 0
        let maxRange = Int(maxWidth(proxy))
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
