//
//  TimeView.swift
//  Flashzilla
//
//  Created by Tino on 9/4/21.
//

import SwiftUI

struct TimeView: View {
    @Binding var time: Int
    let showingSeconds: Bool
    init(time: Binding<Int>, showingSeconds: Bool = true) {
        _time = time
        self.showingSeconds = showingSeconds
    }
    
    var body: some View {
        Text("Time: \(showingSeconds ? "\(time)" : formattedDisplay)")
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .fill(Color.black)
                    .opacity(0.75)
            )
    }
}

extension TimeView {
    var formattedDisplay: String {
        let hours = time / (60 * 60)
        var remainder = time % (60 * 60)
        let minutes = remainder / 60
        remainder = remainder % 60
        let seconds = remainder
        let hh = String(format: "%02d", hours)
        let mm = String(format: "%02d", minutes)
        let ss = String(format: "%02d", seconds)
        if hours > 0 {
            return "\(hh):\(mm):\(ss)"
        }
        return "\(mm):\(ss)"
    }
}


struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(time: .constant(100))
    }
}
