//
//  ContentView.swift
//  DiceRoll
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = Tab.roll
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RollView(selection: $selectedTab)
                .tabItem {
                    Text("Roll")
                }
                .tag(Tab.roll)
            ResultsView()
                .tabItem {
                    Text("Results")
                }
                .tag(Tab.result)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
