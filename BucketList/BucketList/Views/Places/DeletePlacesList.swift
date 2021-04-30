//
//  DeletePlacesList.swift
//  BucketList
//
//  Created by Tino on 30/4/21.
//

import SwiftUI

struct DeletePlacesList: View {
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

struct DeletePlacesList_Previews: PreviewProvider {
    static var previews: some View {
        DeletePlacesList()
            .environmentObject(PlacesContainer())
    }
}
