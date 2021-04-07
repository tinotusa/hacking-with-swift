//
//  PersonDetail.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import SwiftUI
import MapKit

struct PersonDetail: View {
    let person: Person
    @ObservedObject var peopleMet: PeopleMet
    @State private var showEditScreen = false
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    LabeledMapLocation(label: "Met here", location: person.locationWhenAdded, geometry: geometry)
                    
                    image(for: person, withGeometry: geometry)
                    
                    Text(capitalizedName)
                        .font(.largeTitle)
                        .fontWeight(.light)

                    Text(person.description)

                    Text("Met: \(person.formattedDate)")
                    
                    Button(action: { showEditScreen = true }) {
                        Text("Edit info")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showEditScreen) {
            EditView(person: person, peopleMet: peopleMet)
        }
    }
}

// MARK: Functions
extension PersonDetail {
    var capitalizedName: String {
        person.name.capitalized
    }
    
    func saveEdit() {
        peopleMet.edit(person, name: name, description: description)
        showEditScreen = false
    }
    
    func image(for person: Person, withGeometry geometry: GeometryProxy) -> some View {
        person.getImage()
            .resizable()
            .scaledToFit()
            .frame(
                width: geometry.size.width,
                height: geometry.size.height * 0.3
            )
            .clipShape(Circle())
            .accessibility(label: Text("Photo of \(person.name)"))
    }
}

// MARK: Previews
struct PersonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetail(person: Person(name: "test user"), peopleMet: PeopleMet())
    }
}
