//
//  UnlockedView.swift
//  BucketList
//
//  Created by Tino on 6/4/21.
//

import SwiftUI
import MapKit

struct UnlockedView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingEditScreen: Bool
    @Binding var alertItem: AlertItem?

    var body: some View {
        MapView(
            centerCoordinate: _centerCoordinate,
            selectedPlace: _selectedPlace,
            showingPlaceDetails: _showingPlaceDetails,
            showingEditScreen: _showingEditScreen,
            alertItem: _alertItem,
            annotations: locations
        )
            .edgesIgnoringSafeArea(.all)
        Circle()
            .fill(Color.blue)
            .opacity(0.3)
            .frame(width: 32, height: 32)
        FloatingButton(action: addLocation)
    }
    
    func addLocation() {
        let newLocation = CodableMKPointAnnotation()
        newLocation.coordinate = centerCoordinate
        newLocation.title  = "Name"
        newLocation.subtitle  = "Subtitle"
        locations.append(newLocation)
        
        selectedPlace = newLocation
        showingEditScreen = true
    }
}
