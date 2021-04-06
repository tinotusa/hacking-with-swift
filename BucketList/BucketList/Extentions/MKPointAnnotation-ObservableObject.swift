//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Tino on 6/4/21.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    var wrappedTitle: String {
        get { title ?? "Unknown value" }
        set { title = newValue }
    }
    
    var wrappedSubtitle: String {
        get { subtitle ?? "Unknown value" }
        set { subtitle = newValue }
    }
}
