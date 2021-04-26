//
//  AstronautDetail.swift
//  Moonshot
//
//  Created by Tino on 23/4/21.
//

import SwiftUI

struct AstronautDetail: View {
    let astronaut: Astronaut

    @Environment(\.presentationMode) var presentationMode
    
    init(named name: String) {
        let index = Constants.astronauts.firstIndex(where: {$0.id == name })!
        astronaut = Constants.astronauts[index]
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
    }
    
    var body: some View {
        ZStack {
            Constants.background
            
            ScrollView {
                VStack(alignment: .leading) {
                    backButton
                    
                    astronautDetails
                    
                    Divider()
                    
                    Text(astronaut.description)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Divider()
                    
                    Text("Missions flown")
                        .font(.title)
                    
                    missionsList
                    
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.horizontal)
            }
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
}

private extension AstronautDetail {
    var astronautDetails: some View {
        HStack {
            AstronautProfile(astronaut: astronaut, size: .large)
            VStack(alignment: .leading, spacing: 6) {
                Text(astronaut.name)
                    .font(.title2)
                Text(astronaut.birthday)
                    .font(.subheadline)
                
            }
        }
    }
    
    var missionsList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(missionsFlown) { mission in
                    VStack {
                        MissionBadge(mission: mission, size: .large)
                        Text(mission.displayName)
                            .font(.subheadline)
                    }
                }
            }
        }
    }
    
    var missionsFlown: [Mission] {
        var missions: [Mission] = []
        for mission in Constants.missions {
            // if this astronaut was in the crew for this mission
            if let _ = mission.crew.first(where: { $0.name == astronaut.id }) {
                missions.append(mission)
            }
        }
        return missions
    }
    
    var backButton: some View {
        Button(action: dismiss) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(.blue)
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AstronautDetail_Previews: PreviewProvider {
    static var previews: some View {
        AstronautDetail(astronaut: Constants.astronauts[7])
    }
}
