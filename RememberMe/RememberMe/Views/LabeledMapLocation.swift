//
//  LabeledMapLocation.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import SwiftUI
import MapKit

struct LabeledMapLocation: View {
    let label: String
    let location: CLLocationCoordinate2D
    let geometry: GeometryProxy
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(
                coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: location,
                        span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
                ),
                annotationItems: [location]
            ) { pin in
                MapPin(coordinate: pin)
            }
            .edgesIgnoringSafeArea(.all)
            .frame(
                width: geometry.size.width,
                height: geometry.size.height * 0.2
            )
            Text(label)
                .padding(.horizontal, 10)
                .font(.title)
                .foregroundColor(.white)
                .background(Color.black.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .padding()
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("Map with pin"))
    }
}
