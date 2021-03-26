//
//  ContentView.swift
//  Moonshot
//
//  Created by Tino on 25/3/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingDates = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionDetail(mission: mission, astronauts: astronauts)) {
                    MissionRow(mission: mission, showLaunchDates: showingDates)
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("Show \(showingDates ? "Crew" : "Dates")") {
                showingDates.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
