//
//  Patient.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/10/21.
//

import UIKit

class Patient: NSObject {
    
    var firstName : String?
    
    var lastName : String?
    
    var streetAddress : String? {
        didSet {
            if let address = streetAddress {
                LocationCalculator.shared.coordinateFrom(address: address) { coordinate in
                    self.longitude = coordinate.longitude
                    self.latitude = coordinate.latitude
                }
            }
        }
    }
    
    var longitude : Double?
    
    var latitude : Double?
    
    var notes : String?
    
    var birthday : Date?
    
    var id : String?

}
