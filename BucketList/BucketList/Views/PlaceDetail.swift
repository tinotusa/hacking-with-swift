//
//  PlaceDetail.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI
import MapKit

struct PlaceDetail: View {
    @Environment(\.presentationMode) var presentationMode
    let place: Place
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: place.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6))
    }
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading) {
                Map(coordinateRegion: .constant(region))
                    .frame(height: 300)
                    .ignoresSafeArea()
                
                Image("default")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .padding(.top, -150)
                
                Text("Near by Places")
                    .font(.largeTitle)
                // show list from wikipedia
                Spacer()
            }
            
            backButton
                .floatView(to: .topLeft)
                .padding(.leading)
        }
        .navigationBarHidden(true)
    }
    
    var backButton: some View {
        Button(action: dismiss) {
            Image(systemName: "chevron.left")
            Text("Back")
        }
        .font(.title3)
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetail(place: Place.example)
    }
}
