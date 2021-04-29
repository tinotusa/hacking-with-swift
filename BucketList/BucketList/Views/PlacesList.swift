//
//  PlacesList.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI

struct DeleteList: View {
    @EnvironmentObject var places: PlacesContainer
    
    var body: some View {
        List {
            ForEach(places.places) { place in
                HStack {
                    Image("default")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text(place.name)
                }
            }
            .onDelete(perform: places.remove)
            .onMove(perform: places.move)
        }
        .toolbar {
            EditButton()
        }
    }
}

struct PlacesList: View {
    
    @State private var showingAddScreen = false
    @State private var showingDeleteList = false
    @EnvironmentObject var places: PlacesContainer
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: AddPlace(), isActive: $showingAddScreen) { EmptyView() }
                NavigationLink(destination: DeleteList(), isActive: $showingDeleteList) { EmptyView() }
                ScrollView {
                    ForEach(places.places, id: \.id) { place in
                        PlaceRow(place: place)
                    }
                }
            }
            .navigationTitle("Places to visit")
            .toolbar {
                HStack {
                    Button(action: { showingAddScreen = true }) {
                        Image(systemName: "plus")
                    }
                    Button(action: { showingDeleteList = true }) {
                        Image(systemName: "trash")
                    }
                }
            }
        }
    }
}

struct PlacesList_Previews: PreviewProvider {
    static var previews: some View {
        PlacesList()
            .environmentObject(PlacesContainer())
    }
}
