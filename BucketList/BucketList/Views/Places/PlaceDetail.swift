//
//  PlaceDetail.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI
import MapKit

struct PlaceDetail: View {
    
    let place: Place
    
    @Environment(\.presentationMode) var presentationMode
    @State private var nearbyPlaces: WikipediaResult? = nil
    @State private var loadingState: LoadingState = .loading
    @State private var imageURL: String?
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Map(coordinateRegion: .constant(region))
                    .frame(height: 300)
                    .ignoresSafeArea()
                
                HStack {
                    Spacer()
                    if imageURL != nil {
                        AsyncImage(url: URL(string: imageURL!)!) { Text("loading...") }
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .padding(.top, -150)
                    }
                    Spacer()
                }
                
                Text("Near by Places")
                    .font(.largeTitle)
                
                switch loadingState {
                case .loaded:
                    NearbyList(pages: Array(nearbyPlaces!.query.pages.values))
                case .loading:
                    // try to show a loading icon here
                    Text("loading...")
                case .error:
                    Text("Error, no nearby places found")
                }
                
                Spacer()
            }

            backButton
                .floatView(to: .topLeft)
                .padding(.leading)
        }
        .navigationBarHidden(true)
        .onAppear(perform: loadNearbyPlaces)
        .onAppear(perform: loadPlaceImage)
    }
    
    var backButton: some View {
        Button(action: dismiss) {
            Image(systemName: "chevron.left")
            Text("Back")
        }
        .font(.title3)
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: place.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6))
    }
    
    enum LoadingState {
        case loading, loaded, error
    }
    
    func loadPlaceImage() {
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
                imageURL = result.urls["regular"]
            case .failure(_):
                print("something went wrong")
            }
        }
    }
    
    
    func loadNearbyPlaces() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "en.wikipedia.org"
        components.path = "/w/api.php"
        components.queryItems = [
            .init(name: "action", value: "query"),
            .init(name: "generator", value: "geosearch"),
            .init(name: "prop", value: "coordinates|pageimages|pageterms"),
            .init(name: "ggscoord", value: "\(place.coordinates.latitude)|\(place.coordinates.longitude)"),
            .init(name: "format", value: "json")
        ]
        let url = components.url!
        loadJSON(from: url.absoluteString) { (result: Result<WikipediaResult, NetworkError>) in
            switch result {
            case .success(let wikiResult):
                nearbyPlaces = wikiResult
                loadingState = .loaded

            case .failure(let error):
                switch error {
                case .url:
                    print("invalid url")
                    loadingState = .error
                case .server(let serverError):
                    print("server error")
                    print(serverError.localizedDescription)
                    loadingState = .error
                case .response(let response):
                    let httpResponse = response as! HTTPURLResponse
                    print(httpResponse.statusCode)
                    loadingState = .error
                case .decoding(let decodingError):
                    print("decoding error")
                    print(decodingError.localizedDescription)
                    loadingState = .error
                }
            }
        }
    }
    
}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetail(place: Place.example)
    }
}
