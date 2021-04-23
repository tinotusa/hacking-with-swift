//
//  MissionDetail.swift
//  Moonshot
//
//  Created by Tino on 23/4/21.
//

import SwiftUI

struct MissionDetail: View {
    let mission: Mission
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()
            
            ScrollView {
                HStack {
                    backButton
                    Spacer()
                }
                .padding(.horizontal)
                VStack(alignment: .center) {
                    
                    
                    Text(mission.displayName)
                        .font(.largeTitle)
                        .underline()
                    
                    Spacer()
                    Text(mission.description)
                    
                    Divider()
                    Text("Astronauts")
                        .font(.title)
                    
                    ForEach(mission.crew) { crewMember in
                        NavigationLink(destination: AstronautDetail(named: crewMember.name)) {
                            AstronautRow(named: crewMember.name)
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
    }
    
    var background: some View {
        ZStack {
            Color.black
            Image("moon")
                .resizable()
                .scaledToFit()
                .offset(x: 280)
                
        }
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

struct MissionDetail_Previews: PreviewProvider {
    static var previews: some View {
        MissionDetail(mission: Constants.missions[1])
    }
}
