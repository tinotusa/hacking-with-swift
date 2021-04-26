//
//  AstronautProfile.swift
//  Moonshot
//
//  Created by Tino on 23/4/21.
//

import SwiftUI

struct AstronautProfile: View {
    let astronaut: Astronaut
    let size: Size
    
    enum Size {
        case small, medium, large
    }
    
    init(named name: String, size: Size = .medium) {
        let index = Constants.astronauts.firstIndex(where: {$0.id == name })!
        astronaut = Constants.astronauts[index]
        self.size = size
    }
    
    init(astronaut: Astronaut, size: Size = .medium) {
        self.astronaut = astronaut
        self.size = size
    }

    var body: some View {
        Image(astronaut.id)
            .resizable()
            .scaledToFill()
            .frame(width: frameSize, height: frameSize)
            .clipShape(Circle())
    }
    
    var frameSize: CGFloat {
        switch size {
        case .small: return 50
        case .medium: return 80
        case .large: return 150
        }
    }
}

struct AstronautProfile_Previews: PreviewProvider {
    static var previews: some View {
        AstronautProfile(astronaut: Constants.astronauts[0])
    }
}
