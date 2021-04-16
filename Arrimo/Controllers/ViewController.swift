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
        
        view.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.text = "Hi there"
        view.addSubview(label)
        label.center = view.center
        label.font = UIFont.kufam(size: 24)
        
        // Do any additional setup after loading the view.
    }


}

