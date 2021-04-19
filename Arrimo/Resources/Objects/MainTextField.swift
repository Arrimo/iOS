//
//  CustomTextField.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/19/21.
//

import UIKit

class MainTextField: UITextField {
    
    init(placeholderString: String) {
        super.init(frame: .zero)
        
        let placeholderStringAttr = NSAttributedString(string: placeholderString, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        
        textColor = UIColor.black
        
        attributedPlaceholder = placeholderStringAttr
        
        tintColor = UIColor.mainOrange
        
        backgroundColor = UIColor.white
        
        borderStyle = BorderStyle.roundedRect
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        
        font = UIFont.kufam(size: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("error fatal")
    }
    
}
