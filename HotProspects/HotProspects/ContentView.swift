//
//  ContentView.swift
//  HotProspects
//
//  Created by Tino on 7/4/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var prospectList: ProspectList
    
    var body: some View {
        TabView {
            ProspectsTab(tab: .all)
                .tabItem {
                    Label("all", systemImage: "person.3")
                }
            ProspectsTab(tab: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "star")
                }
            Text("My details")
                .tabItem {
                    Label("My Details", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ProspectList())
    }
}
