//
//  PlaceRow.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI

struct PlaceRow: View {
    let place: Place
    @State private var showingPlaceDetail = false
    @State private var image: Image? = nil
    // get url from unsplash ???? search by the name of the place
    let url = URL(string: "https://www.nationsonline.org/gallery/Switzerland/Sunrise-on-the-Matterhorn.jpg")!
    
    var body: some View {
        ZStack {
            
            NavigationLink(destination: PlaceDetail(place: place), isActive: $showingPlaceDetail) { EmptyView() }
            
            AsyncImage(url: url) {
                Text("loading...")
            }
            .scaledToFill()
            .frame(width: 390, height: 200)
            .cornerRadius(32)
            .shadow(radius: 10)
        
            Text(place.name.capitalized)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .floatView(to: .bottomLeft)
                .padding(.bottom)
                .padding(.leading, 30)
        }
        .padding(.bottom)
        .onTapGesture {
            showingPlaceDetail = true
        }
    }
}

struct PlaceRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaceRow(place: Place.example)
    }
}
