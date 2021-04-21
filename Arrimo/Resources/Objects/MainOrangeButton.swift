//
//  MainOrangeButton.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/21/21.
//

import UIKit

class MainOrangeButton: UIButton {
    
    init(title buttonTitle: String) {
        super.init(frame: .zero)
        
        titleLabel?.font = UIFont.tekturBold(size: 30)
        
        layer.cornerRadius = 125
        
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 50
        layer.shadowOffset = CGSize(width: 250, height: 250)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor.mainOrange
        
        setTitleColor(UIColor.white, for: UIControl.State.normal)
        setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        setTitle(buttonTitle, for: UIControl.State.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("error fatal")
    }
    
}
