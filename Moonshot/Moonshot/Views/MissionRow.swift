//
//  MissionRow.swift
//  Moonshot
//
//  Created by Tino on 26/3/21.
//

import SwiftUI

struct MissionRow: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    let mission: Mission
    let showLaunchDates: Bool
    
    var crewNames: [String]
    
    init(mission: Mission, showLaunchDates: Bool = true) {
        self.mission = mission
        self.showLaunchDates = showLaunchDates
        crewNames = []
        
        for crewMember in mission.crew {
            if let matched = astronauts.first(where: { $0.id == crewMember.name }) {
                crewNames.append(matched.name)
            }
        }
    }
    
    var names: String {
        crewNames.joined(separator: " | ")
    }
    
    var body: some View {
        HStack {
            Image(decorative: mission.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .accessibility(hidden: true)

            VStack(alignment: .leading, spacing: 0) {
                Text(mission.displayName)
                    .font(.headline)
                
                if showLaunchDates {
                    Text(mission.formattedLaunchDate)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        Text(names)
                    }
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("\(mission.displayName) mission"))

            Spacer()
        }
    }
}

struct MissionRow_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        MissionRow(mission: missions.first!, showLaunchDates: false)
    }
}
