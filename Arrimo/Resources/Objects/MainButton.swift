//
//  MainButton.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/19/21.
//

import UIKit

class MainButton : UIButton {
    
    init(title buttonTitle: String) {
        super.init(frame: .zero)
        
        titleLabel?.font = UIFont.tekturBold(size: 16)
        titleLabel?.text = titleLabel?.text?.uppercased()
        
        layer.cornerRadius = 12
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor.darkBlue
        
        setTitleColor(UIColor.white, for: UIControl.State.normal)
        setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        setTitle(buttonTitle, for: UIControl.State.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("error fatal")
    }
    
}
