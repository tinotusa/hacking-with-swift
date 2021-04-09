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
        GeometryReader { fullGeometry in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { iamgeGeometry in
                        Image(decorative: mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: fullGeometry.size.width)
                            .scaleEffect(scaleFactor(parent: fullGeometry, child: iamgeGeometry))
                            .padding(.top)
                            .accessibility(hidden: true)
                    }
                    Text("Launch date: \(mission.formattedLaunchDate)")
                    
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

extension MissionDetail {
    func scaleFactor(parent: GeometryProxy, child: GeometryProxy) -> CGFloat {
        return max(0.8, min(1.1, child.frame(in: .global).maxY / (parent.size.height * 0.3)))
    }
}

struct MissionDetail_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionDetail(mission: missions[10], astronauts: astronauts)
    }
}
