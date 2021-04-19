//
//  Constants.swift
//  WordScramble
//
//  Created by Tino on 19/4/21.
//

import Foundation
import SwiftUI

struct Constants {
    static var background: some View {
        RadialGradient(gradient: Gradient(colors: [Color("gradientStart"), Color("gradientEnd")]),
                       center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                       startRadius: 10,
                       endRadius: 400
        )
    }
}
