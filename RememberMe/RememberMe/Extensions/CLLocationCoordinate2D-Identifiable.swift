//
//  CLLocationCoordinate2D-Identifiable.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
