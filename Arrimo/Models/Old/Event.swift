//
//  Event.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/10/21.
//

import UIKit
import Foundation

class Event: NSObject {
    
    var patient : Patient?
    
    var employee : Employee?
    
    var tasks : [Task]?
    
    var startTime : Int?
    
    var endTime : Int?
    
    var completed : Bool?

}

class Visit : NSObject {
    
    var patient : Patient?
    
    var employee : Employee?
    
    var startTime : Date?
    
    var tasks : [Task1]?

}

class Task1 : NSObject {
    
    var title : String?
    
    var duration : Int?
    
}

