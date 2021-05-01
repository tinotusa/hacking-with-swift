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
    @State private var imageURL: URL?
    
    var body: some View {
        ZStack {
            NavigationLink(destination: PlaceDetail(place: place), isActive: $showingPlaceDetail) { EmptyView() }
            
            if imageURL != nil {
                AsyncImage(url: imageURL!) {
                    Text("loading...")
                }
                .scaledToFill()
                .frame(width: 390, height: 200)
                .cornerRadius(32)
                .shadow(radius: 10)
            }
        
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
        .onAppear(perform: loadBackgroundImage)
    }
    
    func loadBackgroundImage() {
    
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/random"
        let parameters = [
            "query": "\(place.name)",
            "format": "json",
            "client_id": accessKey
        ]
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        loadJSON(from: components.url!.absoluteString) { (result: Result<UnsplashResult, NetworkError>) in
            switch result {
            case .success(let result):
                imageURL = URL(string: result.urls["regular"] ?? "")
            case .failure(_):
                print("something went wrong")
            }
        }
    }
}

struct PlaceRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaceRow(place: Place.example)
    }
}
