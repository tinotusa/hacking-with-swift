//
//  AddView.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import SwiftUI
import MapKit

struct AddView: View {
    @ObservedObject var peopleMet: PeopleMet
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedImage: UIImage?
    @State private var name = ""
    @State private var description = ""
    
    @State private var alertItem: AlertItem?
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ImageSelect(selectedImage: $selectedImage)
                
                Form {
                    Section {
                        TextField("Name", text: $name)
                        TextField("Description", text: $description)
                    }
                }
            }
            .navigationBarTitle("Add person")
            .navigationBarItems(trailing: Button("Add", action: addPerson))
        }
        .alert(item: $alertItem) { item in
            Alert(
                title: Text(item.title),
                message: item.message != nil ? Text(item.message!) : nil,
                dismissButton: item.primaryButton ?? .default(Text("OK"))
            )
        }
        .onAppear(perform: locationFetcher.start)
    }
}

// MARK: Functions
extension AddView {
    func addPerson() {
        if selectedImage == nil {
            alertItem = AlertItem(
                title: "Error",
                message: "No image selected"
            )
            return
        } else if name.isEmpty {
            alertItem = AlertItem(
                title: "Error",
                message: "Enter a name"
            )
            return
        }
        // description isn't checked because it can be empty
        
        var newPerson = Person(name: name, description: description)
        if let location = locationFetcher.lastKnownLocation {
            newPerson.locationWhenAdded.latitude = location.latitude
            newPerson.locationWhenAdded.longitude = location.longitude
        }
        
        // since selected image is checked about its safe to force this
        let image = self.selectedImage!
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            fatalError("Failed to get image data")
        }
        let imageURL = FileManager.default.documentsURL().appendingPathComponent(newPerson.imagePath)
        do {
            try imageData.write(to: imageURL)
        } catch {
            print("Unresolved error \(error.localizedDescription)")
        }
        peopleMet.add(newPerson)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(peopleMet: PeopleMet())
    }
}
