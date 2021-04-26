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

// MARK: - Functions and properties
extension ContentView {
    // TODO
//    enum SortKey: String, CaseIterable {
//        case none, alphabetical, country
//    }
//    enum FilterKey: String, CaseIterable {
//        case none, country, size, price
//    }
//
//    var filteredResorts: [Resort] {
//        switch filterKey {
//        case .none:     return resorts
//        case .country:  return resorts.sorted { $0.country < $1.country }
//        case .size:     return resorts.sorted { $0.size > $1.size }
//        case .price:    return resorts.sorted { $0.price > $1.price }
//        }
//    }
    
//    var sortedResorts: [Resort] {
//        switch sortKey {
//        case .none:         return filteredResorts
//        case .alphabetical: return filteredResorts.sorted { $0.name < $1.name }
//        case .country:      return filteredResorts.sorted { $0.country < $1.country }
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Favourites())
    }
}
