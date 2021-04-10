//
//  SkiInformation.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

struct SkiInformation: View {
    let resort: Resort
    
    var body: some View {
        Group {
            Text("Elevation: \(resort.elevation)m")
            Spacer().frame(height: 0)
            Text("Snow: \(resort.snowDepth)cm")
        }
    }
}

struct SkiInformation_Previews: PreviewProvider {
    static var previews: some View {
        SkiInformation(resort: Resort.example)
    }
}
