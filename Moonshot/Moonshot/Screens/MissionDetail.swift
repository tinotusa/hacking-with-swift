//
//  MissionDetail.swift
//  Moonshot
//
//  Created by Tino on 26/3/21.
//

import SwiftUI

struct MissionDetail: View {
    let mission: Mission
    var astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMember]()
        
        for member in mission.crew {
            guard let matchedAstronaut = astronauts.first(where: { $0.id == member.name }) else {
                fatalError("Missing crew memeber \(member)")
            }
            let crewMember = CrewMember(role: member.role, astronaut: matchedAstronaut)
            matches.append(crewMember)
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(mission.description)
                        .padding()
                    
                    Text("Astronauts")
                        .font(.title)
                        .fontWeight(.light)
                    
                    ForEach(astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautDetail(astronaut: crewMember.astronaut)) {
                            CrewMemberRow(member: crewMember)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(mission.displayName, displayMode: .inline)
    }
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
}

struct MissionDetail_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionDetail(mission: missions[10], astronauts: astronauts)
    }
}
