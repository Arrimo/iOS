//
//  ViewController.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/15/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.text = "Welcome".localized()
        view.addSubview(label)
        label.textColor = UIColor.darkBlue
        label.center = view.center
        label.font = UIFont.tekturBold(size: 32)
        label.textAlignment = NSTextAlignment.center
        
        // Do any additional setup after loading the view.
    }


}

