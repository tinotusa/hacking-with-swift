//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @EnvironmentObject var favourites: Favourites
    
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink(destination: ResortDetail(resort: resort)) {
                    ResortRow(resort: resort)
                    if favourites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            WelcomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Favourites())
    }
}
