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
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                        
                    Text("Photo by: \(resort.imageCredit)")
                        .font(.subheadline)
                        .padding(5)
                        .background(Color.black.opacity(0.4))
                        .foregroundColor(Color(red: 225 / 255, green: 225 / 255, blue: 235/255))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(5)
                        
                    
                }
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

// MARK: - Preview
struct ResortDetail_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetail(resort: Resort.example)
            .environmentObject(Favourites())
    }
}
