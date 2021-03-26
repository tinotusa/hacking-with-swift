//
//  AstronautDetail.swift
//  Moonshot
//
//  Created by Tino on 26/3/21.
//

import SwiftUI

struct AstronautDetail: View {
    let astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(astronaut.description)
                        .padding()
                }
            }
        }
        .navigationBarTitle(astronaut.name, displayMode: .inline)
    }
}

struct AstronautDetail_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautDetail(astronaut: astronauts.first!)
    }
}
