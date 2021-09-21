//
//  BankAccountDto.swift
//  Arrimo
//
//  Created by JJ Zapata on 9/10/21.
//

import Foundation

struct BankAccountDto : Codable {
    
    let bankName : String
    
    let bankCode : Int
    
    let acountNumber : Int
    
    let IBAN : String
    
    let BIC : String
    
}
