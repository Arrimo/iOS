//
//  Strings.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/16/21.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: self, comment: self)
    }
    
}
