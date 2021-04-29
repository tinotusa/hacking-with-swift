//
//  PlaceRow.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI

struct PlaceRow: View {
    let place: Place
    let imageLoader = ImageLoader()
    @State private var showingPlaceDetail = false
    @State private var image: Image? = nil
    
    var body: some View {
        ZStack {
            
            NavigationLink(destination: PlaceDetail(place: place), isActive: $showingPlaceDetail) { EmptyView() }
            
            image?
                .resizable()
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
        .onAppear {
//            if let uiImage = imageLoader.load(string: "some unsplash url string here based on the name") {
//                // MARK: - TODO
//                // fix this
////                image = Image(uiImage: uiImage)
//                image = Image("default")
//            }
            image = Image("default")
        }
    }
}

struct PlaceRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaceRow(place: Place.example)
    }
}
