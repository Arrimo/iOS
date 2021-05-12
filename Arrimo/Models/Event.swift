//
//  Event.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/10/21.
//

import UIKit

class Event: NSObject {
    
    var patient : Patient?
    
    var caretaker : Caretaker?
    
    var tasks : [Task]?
    
    var startTime : Int?
    
    var endTime : Int?
    
    var completed : Bool?

}
