//
//  UIAlertController.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/12/21.
//

import UIKit

extension UIAlertController {
    
    static func customActionWithCancel(title: String, message: String, onConfirm: @escaping () -> Void) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue".localized(), style: .default) { _ in onConfirm() })
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel))
        
        return alert
    }
    
}
