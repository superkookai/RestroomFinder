//
//  Restroom.swift
//  RestroomFinder
//
//  Created by Weerawut Chaiyasomboon on 22/04/2568.
//

import Foundation
import CoreLocation
import MapKit
import Contacts

struct Restroom: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let street: String
    let city: String
    let state: String
    let accessible: Bool
    let unisex: Bool
    let directions: String
    let comment: String?
    let changingTable: Bool
    let latitude: Double
    let longitude: Double
    
    var address: String {
        "\(street), \(city) \(state)"
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    enum CodingKeys: String, CodingKey, Decodable {
        case id
        case name
        case street
        case city
        case state
        case accessible
        case unisex
        case directions
        case comment
        case changingTable = "changing_table"
        case latitude
        case longitude
    }
}

extension Restroom {
    var mapItem: MKMapItem {
        var addressDictionary: [String: Any] = [
            CNPostalAddressStreetKey: self.street,
            CNPostalAddressCityKey: self.city,
            CNPostalAddressStateKey: self.state
        ]
        
        let placeMark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = self.name
        return mapItem
    }
}

//13.721255990594251, 100.62030225767161 >> MyPlace

//{
//    "id": 102898,
//    "name": "Haraz Coffee House",
//    "street": "471 Elmwood Avenue",
//    "city": "Buffalo",
//    "state": "New York",
//    "accessible": false,
//    "unisex": true,
//    "directions": "in the back",
//    "comment": "",
//    "latitude": 42.9100653,
//    "longitude": -78.8768158,
//    "created_at": "2025-04-20T23:32:13.116Z",
//    "updated_at": "2025-04-20T23:32:13.229Z",
//    "downvote": 0,
//    "upvote": 0,
//    "country": "US",
//    "changing_table": false,
//    "edit_id": 102898,
//    "approved": true
//  }
