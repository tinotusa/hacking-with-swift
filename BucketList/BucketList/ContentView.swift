//
//  ContentView.swift
//  BucketList
//
//  Created by Tino on 5/4/21.
//

import SwiftUI
import MapKit

struct FloatingButton: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack() {
                Spacer()
                Button(action: action) {
                    Image(systemName: "plus")
                }
                .padding()
                .background(Color.black.opacity(0.75))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                .padding(.trailing)
            }
        }
    }
}

struct ContentView: View  {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    var body: some View {
        ZStack {
            MapView(
                centerCoordinate: $centerCoordinate,
                selectedPlace: $selectedPlace,
                showingPlaceDetails: $showingPlaceDetails,
                annotations: locations
            )
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            FloatingButton(action: addLocation)
        }
        .alert(isPresented: $showingPlaceDetails) {
            Alert(
                title: Text(selectedPlace?.title ?? "Unknown"),
                message: Text(selectedPlace?.subtitle ?? "Missing place information"),
                primaryButton: .default(Text("OK")),
                secondaryButton: .default(Text("Edit"))
            )
        }
    }
    
    func addLocation() {
        let newLocation = MKPointAnnotation()
        newLocation.coordinate = centerCoordinate
        newLocation.title  = "Example location"
        locations.append(newLocation)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
