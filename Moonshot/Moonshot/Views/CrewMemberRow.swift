//
//  CrewMemberRow.swift
//  Moonshot
//
//  Created by Tino on 26/3/21.
//

import SwiftUI

struct CrewMemberRow: View {
    let member: MissionDetail.CrewMember
    
    var body: some View {
        HStack {
            Image(decorative: member.astronaut.id)
                .resizable()
                .frame(width: 83, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            isCommander(member) ? Color.green : Color.primary,
                            lineWidth: 1
                        )
                )
                .shadow(radius: 5)
                .accessibility(hidden: true)

            VStack(alignment: .leading) {
                Text(member.astronaut.name)
                    .font(.headline)
                Text(member.role)
                    .foregroundColor(.secondary)
            }
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("\(member.astronaut.name) the mission's \(member.role)"))
            
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    
    func isCommander(_ member: MissionDetail.CrewMember) -> Bool {
        member.role == "Commander"
    }
}

struct CrewMemberRow_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        CrewMemberRow(member: MissionDetail.CrewMember(role: "Command Pilot", astronaut: astronauts.first!))
    }
}
