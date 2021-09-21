//
//  RunningInfo.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/12/21.
//

import Foundation

class RunningInfo {
    
    var employee : Employee?
    
    static let shared = RunningInfo()
    
    var events : [Event]?
    
    var routeIndex = Int()
    
}
