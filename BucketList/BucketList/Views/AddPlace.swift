//
//  AddPlace.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI
import MapKit

struct AddPlace: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var places: PlacesContainer
    
    @State private var name = ""
    @State private var region = MKCoordinateRegion(
        center:
            CLLocationCoordinate2D(latitude: 25.734968, longitude: 134.489563),
        span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))

    @State private var searchText = ""
    @State private var showAddSheet = false
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    
    
    var body: some View {
        ZStack(alignment: .center) {
            Map(coordinateRegion: $region, annotationItems: places.places) { place in
                MapPin(coordinate: place.coordinates)
            }
            .ignoresSafeArea()
            
            Circle()
                .stroke(Color.blue.opacity(0.4))
                .frame(width: 30, height: 30)
            
            VStack {
                HStack {
                    backButton
    
                    Spacer()
                    TextField("Place", text: $searchText, onCommit: searchForPlace)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                Spacer()
            }
            
            addButton
                .floatView(to: .bottomRight)
                .padding(.trailing)
        }
        .sheet(isPresented: $showAddSheet) {
            AddPlaceSheet(name: $searchText, region: region)
        }
        .navigationBarHidden(true)
    }

    var backButton: some View {
        Button(action: dismiss) {
            Image(systemName: "chevron.left")
                .font(.title)
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var addButton: some View {
        Button(action: { showAddSheet = true }) {
            Image(systemName: "plus")
                .font(.largeTitle)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
    
    func searchForPlace() {
        let searchText = self.searchText.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
        if searchText.isEmpty { return }
        
        // url from wiki
        var components = URLComponents()
        components.scheme = "https"
        components.host = "en.wikipedia.org"
        components.path = "/w/api.php"
        let parameters = [
            "action": "query",
            "prop": "coordinates",
            "titles": searchText,
            "format": "json"
        ]
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem.init(name: key, value: value)
        }
        let url = components.url
        // get json from wiki
        // move map to new lat and lon
        loadJSON(from: url!.absoluteString) { (result: Result<WikipediaResult, NetworkError>) in
            switch result {
            case .success(let searchResult):
                if let test = searchResult.query.pages.first?.value {
                    latitude = test.coordinates.first!.lat
                    longitude = test.coordinates.first!.lon
                    DispatchQueue.main.async {
                        withAnimation {
                            region = MKCoordinateRegion(
                                center:
                                    CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                        }
                    }
                }
            case .failure(let error):
                switch error {
                case .url: print("invalid url")
                case .server(let error): print(error.localizedDescription)
                case .response(let response): print("Response error: ", response)
                case .decoding(let error):
                    withAnimation {
                        region = MKCoordinateRegion(
                            center: region.center,
                            span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
                    }
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct AddPlace_Previews: PreviewProvider {
    static var previews: some View {
        AddPlace()
            .environmentObject(PlacesContainer())
    }
}
