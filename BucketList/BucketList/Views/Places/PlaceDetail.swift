//
//  PlaceDetail.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI
import MapKit

struct PlaceDetail: View {
    @Environment(\.presentationMode) var presentationMode
    let place: Place
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: place.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6))
    }
    @State private var nearbyPlaces: WikipediaResult? = nil
    enum LoadingState {
        case loading, loaded, error
    }
    
    @State private var loadingState: LoadingState = .loading
    let url = URL(string: "https://images.unsplash.com/photo-1619720655461-ba20fa0cfec9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=691&q=80")!
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Map(coordinateRegion: .constant(region))
                    .frame(height: 300)
                    .ignoresSafeArea()
                
                AsyncImage(url: url) { Text("loading...") }
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .padding(.top, -150)
                
                Text("Near by Places")
                    .font(.largeTitle)
                
                switch loadingState {
                case .loaded:
                    List {
                        ForEach(Array(nearbyPlaces!.query.pages.values)) { page in
                            HStack {
                                if page.thumbnailURL != nil {
                                    AsyncImage(url: url) {
                                        Text("loading ...")
                                    }
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
                                }
                                VStack(alignment: .leading) {
                                    Text(page.title)
                                        .font(.headline)
                                    Spacer()
                                    Text(page.description)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
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
        .onAppear {
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
}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetail(place: Place.example)
    }
}
