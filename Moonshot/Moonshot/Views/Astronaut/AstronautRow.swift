//
//  AstronautRow.swift
//  Moonshot
//
//  Created by Tino on 23/4/21.
//

import SwiftUI

struct AstronautRow: View {
    let astronaut: Astronaut
    
    init(named name: String) {
        let index = Constants.astronauts.firstIndex(where: { $0.id == name })!
        astronaut = Constants.astronauts[index]
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
    }
    
    var body: some View {
        HStack {
            AstronautProfile(astronaut: astronaut, size: .medium)
            
            VStack(alignment: .leading) {
                Text(astronaut.name)
                    .font(.title)
                Text(astronaut.birthday)
            }
            
            
            Spacer()
        }
        .foregroundColor(.white)
    }
}

struct AstronautRow_Previews: PreviewProvider {
    static var previews: some View {
        AstronautRow(astronaut: Constants.astronauts[0])
    }
}
