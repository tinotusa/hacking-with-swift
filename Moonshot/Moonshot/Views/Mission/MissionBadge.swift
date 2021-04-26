//
//  MissionBadge.swift
//  Moonshot
//
//  Created by Tino on 23/4/21.
//

import SwiftUI

struct MissionBadge: View {
    let mission: Mission
    let size: Size
    
    init(mission: Mission, size: Size = .medium) {
        self.mission = mission
        self.size = size
    }
    
    enum Size {
        case small, medium, large
    }
    
    var body: some View {
        Image(mission.name)
            .resizable()
            .scaledToFit()
            .frame(width: frameSize, height: frameSize)
    }
    
    var frameSize: CGFloat {
        switch size {
        case .small: return 60
        case .medium: return 90
        case .large: return 150
        }
    }
}
struct MissionBadge_Previews: PreviewProvider {
    static var previews: some View {
        MissionBadge(mission: Constants.missions[0])
    }
}
