//
//  1Patient.swift
//  Arrimo
//
//  Created by JJ Zapata on 10/6/21.
//

import Foundation

struct Patient1 : Codable {
    
    let id : String?
    
    let createdAt : String?
    
    let updatedAt : String?
    
    let formOfAddress : String?
    
    let firstName : String?
    
    let maidenName : String?
    
    let lastName : String?
    
    let birthdate : String?

    let sex : String?
    
    let status : String?
    
    let religion : String?

    let birthplace : String?
    
    let profession : String?

    let nationalityCode : String?

    let maritalStatus : String?
    
    let phoneNumber : String?
    
    let landlineNumber : String?

    let faxNumber : String?
    
    let mobileNumber : String?
    
    let emailAddress : String?
    
    let illnessSeverity : String?

    let address : AddressDto?
    
    let accessData : AccessDto?
    
    let healthConstitution : HealthConstitutionDto?
    
    let pharmacy : String?
    
    let familyDoctor : String?
    
    let personalSupporter : String?
    
}
