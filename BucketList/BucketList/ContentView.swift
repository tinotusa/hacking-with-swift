//
//  ContentView.swift
//  BucketList
//
//  Created by Tino on 5/4/21.
//

import SwiftUI
import MapKit

struct ContentView: View  {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var isUnlocked = false
    
    @State private var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            switch isUnlocked {
            case true:
                UnlockedView(
                    centerCoordinate: $centerCoordinate,
                    locations: $locations,
                    selectedPlace: $selectedPlace,
                    showingPlaceDetails: $showingPlaceDetails,
                    showingEditScreen: $showingEditScreen,
                    alertItem: $alertItem
                )
            case false:
                LockedView(alertItem: $alertItem, isUnlocked: $isUnlocked)
            }
        }
        .alert(item: $alertItem) { item in
            Alert(
                title: Text(item.title),
                message: Text(item.message ?? ""),
                primaryButton: item.primaryButton ?? .default(Text("OK")),
                secondaryButton: item.secondaryButton ?? .default(Text("Cancel"))
            )
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
}

// MARK: load and save functionality
extension ContentView {
    static let saveFilename = "SavedPlaces"
    
    func loadData() {
        let fileURL = FileManager.default.documentsURL().appendingPathComponent(Self.saveFilename)
        do {
            let data = try Data(contentsOf: fileURL)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load data")
        }
    }
    
    func saveData() {
        do {
            let fileURL = FileManager.default.documentsURL().appendingPathComponent(Self.saveFilename)
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
