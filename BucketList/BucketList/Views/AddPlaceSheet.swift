//
//  AddPlaceSheet.swift
//  BucketList
//
//  Created by Tino on 30/4/21.
//

import SwiftUI
import MapKit

struct AddPlaceSheet: View {
    @Binding var name: String
    let region: MKCoordinateRegion
    
    @State private var subtitle = ""
    @EnvironmentObject var places: PlacesContainer
    @Environment(\.presentationMode) var presentationMode
    
//    init(
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Subtitle", text: $subtitle)
            Button(action: addPlace) {
                Text("Add")
            }
            .disabled(!allFormsFilled)
        }
    }
    
    var allFormsFilled: Bool {
        let name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        return !name.isEmpty
    }
    
    func addPlace() {
        var newPlace = Place(name: name, coordinates: region.center)
        newPlace.subtitle = subtitle
        places.add(newPlace)
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddPlaceSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaceSheet(
            name: .constant("no name"),
            region: MKCoordinateRegion(
                center: Place.example.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
        )
        .environmentObject(PlacesContainer())
    }
}
