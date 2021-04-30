//
//  AddPlace.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI
import MapKit

//struct SearchBar: View {
//    let placeholder: String
//    @Binding var text: String
//
//    init(_ placeholder: String = "Search", text: Binding<String>) {
//        self.placeholder = placeholder
//        _text = text
//    }
//
//    var body: some View {
//        HStack {
//            TextField(placeholder, text: $text)
//                .foregroundColor(.black)
//            Button(action: {}) {
//                Image(systemName: "magnifyingglass")
//                    .font(.title2)
//            }
//        }
//        .padding()
//        .background(Color.white.opacity(0.6))
//        .cornerRadius(20)
//    }
//}


struct AddPlace: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var places: PlacesContainer
    
    @State private var name = ""
    @State private var region = MKCoordinateRegion(
        center:
            CLLocationCoordinate2D(latitude: 25.734968, longitude: 134.489563),
        span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
//    @State private var showingSearchBar = false
    @State private var text = ""
    @State private var showAddSheet = false
    
    var body: some View {
        ZStack(alignment: .center) {
            Map(coordinateRegion: $region, annotationItems: places.places) { place in
                MapPin(coordinate: place.coordinates)
            }
            .ignoresSafeArea()
            
            Circle()
                .stroke(Color.blue.opacity(0.4))
                .frame(width: 30, height: 30)
            
            backButton
                .floatView(to: .topLeft)
                .padding(.leading)
            
            addButton
                .floatView(to: .bottomRight)
                .padding(.trailing)
        }
        .sheet(isPresented: $showAddSheet) {
            AddPlaceSheet(region: region)
        }
        .navigationBarHidden(true)
    }
    
//    var searchButton: some View {
//        Button(action: { showingSearchBar.toggle() }) {
//            Image(systemName: "magnifyingglass")
//                .font(.largeTitle)
//                .foregroundColor(.blue)
//        }
//
//    }
//
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
}

struct AddPlace_Previews: PreviewProvider {
    static var previews: some View {
        AddPlace()
            .environmentObject(PlacesContainer())
    }
}
