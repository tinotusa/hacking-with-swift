//
//  MissionRow.swift
//  Moonshot
//
//  Created by Tino on 23/4/21.
//

import SwiftUI

struct MissionRow: View {
    let mission: Mission
    
    var body: some View {
        HStack {
            MissionBadge(mission: mission, size: .large)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(mission.displayName)
                    .font(.title)
                    .underline()
                
                Text(mission.formattedLaunchDate)
                    .font(.title2)
                
                HStack {
                    ForEach(mission.crew) { crewMember in
                        AstronautProfile(named: crewMember.name, size: .small)
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Spacer()
        }
        .background(Color.black.opacity(0.3))
    }
}


struct MissionRow_Previews: PreviewProvider {
    static var previews: some View {
        MissionRow(mission: Mission(id: 1, launchDate: nil, crew: [], description: "some test"))
    }
}
