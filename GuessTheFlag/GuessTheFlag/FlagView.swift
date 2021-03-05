//
//  FlagView.swift
//  GuessTheFlag
//
//  Created by Tino on 5/3/21.
//

import SwiftUI

struct FlagView: View {
    let flag: String
    
    let angularStroke = AngularGradient(
        gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
        center: .center
    )

    init(for flag: String) {
        self.flag = flag
    }
    
    var body: some View {
        Image(flag)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(angularStroke, lineWidth: 4)
            )
            .shadow(radius: 3)
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagView(for: "Estonia")
    }
}
