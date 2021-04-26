//
//  MissionView.swift
//  Moonshot
//
//  Created by Tino on 23/4/21.
//

import SwiftUI

struct MissionView: View {
    let missions = Constants.missions
    
    var body: some View {
        NavigationView {
            ZStack {
                Constants.background
                    
                ScrollView(showsIndicators: false) {
                    apolloTitle
                    missionsList
                }
            }
            .navigationBarHidden(true)
        }
    }
}

private extension MissionView {
    var apolloTitle: some View {
        Text("Apollo Missions")
            .font(.largeTitle)
            .foregroundColor(.white)
            .underline()
    }
    
    var missionsList: some View {
        VStack {
            ForEach(missions) { mission in
                NavigationLink(destination: MissionDetail(mission: mission)) {
                    MissionRow(mission: mission)
                }
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
    }
}
