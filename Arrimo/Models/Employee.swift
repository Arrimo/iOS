//
//  Employee.swift
//  Arrimo
//
//  Created by JJ Zapata on 9/10/21.
//

import Foundation

struct Employee : Codable {
    
    let id : String?
    
    let createdAt : String?
    
    let updatedAt : String?
    
    let formOfAddress : String?
    
    let firstName : String?
    
    let lastName : String?

    let sex : String?

    let religion : String?

    let birthplace : String?

    let nationalityCode : String?

    let maritalStatus : String?

    let role : String?

    let hiringType : String?

    let workload : String?

    let weeklyHours : Int?

    let address : AddressDto?

    let phoneNumber : String?

    let landlineNumber : String?

    let faxNumber : String?

    let email : String?

    let password : String?

    let bankAccount : BankAccountDto?

    let paymentDate : String?

    let paymentMethod : String?
    
}
