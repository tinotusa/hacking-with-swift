//
//  ResortDetail.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

struct ResortDetail: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favourites: Favourites
    @State private var selectedFacility: Facility? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortInformation(resort: resort) }
                            VStack { SkiInformation(resort: resort) }
                            Spacer()
                        } else {
                            ResortInformation(resort: resort)
                            Spacer().frame(height: 0)
                            SkiInformation(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    FacilityView(resort: resort, selectedFacility: $selectedFacility)
                        .padding(.vertical)
                }
                .padding()
            }
            Button(favouriteText, action: updateFavourites)
                .padding()
        }
        .navigationBarTitle("\(resort.name), \(resort.country)", displayMode: .inline)
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
}

// MARK: - Functions and Properties
extension ResortDetail {
    var favouriteText: String {
        favourites.contains(resort) ? "Remove from Favourites" : "Add to Favourites"
    }
    
    func updateFavourites() {
        favourites.update(resort)
    }
}

struct ResortDetail_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetail(resort: Resort.example)
            .environmentObject(Favourites())
    }
}
