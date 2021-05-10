//
//  Location.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/10/21.
//

import UIKit
import CoreLocation
import Foundation

class LocationCalculator {
    
    static let shared = LocationCalculator()
    
    func coordinateFrom(address: String, completionHandler: @escaping ((_ coordinate : CLLocationCoordinate2D) -> Void)) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { placemark, error in
            if let placemark = placemark {
                let location = placemark.first?.location
                return completionHandler(CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude))
            } else {
                return completionHandler(CLLocationCoordinate2D(latitude: 0, longitude: 0))
            }
        }
    }
    
}
