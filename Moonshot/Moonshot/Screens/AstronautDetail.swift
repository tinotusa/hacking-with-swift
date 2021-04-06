//
//  AstronautDetail.swift
//  Moonshot
//
//  Created by Tino on 26/3/21.
//

import SwiftUI

struct AstronautDetail: View {
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
    var missionsFlown: [Mission]
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        missionsFlown = []
        for mission in missions {
            if let _ = mission.crew.first(where: { $0.name == astronaut.id } ) {
                missionsFlown.append(mission)
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(decorative: astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        .accessibility(hidden: true)

                    Text(astronaut.description)
                        .padding()
                    
                    Text("Missions Flown")

                    ForEach(missionsFlown) { mission in
                        MissionRow(mission: mission)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle(astronaut.name, displayMode: .inline)
    }
}

struct AstronautDetail_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautDetail(astronaut: astronauts[7])
    }
}
