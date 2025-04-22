//
//  MapCameraPosition+Ext.swift
//  RestroomFinder
//
//  Created by Weerawut Chaiyasomboon on 22/04/2568.
//

import Foundation
import MapKit
import SwiftUI

extension MapCameraPosition {
    static var apple: MapCameraPosition {
        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3348826008422, longitude: -122.00899344992547), latitudinalMeters: 100, longitudinalMeters: 100))
    }
}
