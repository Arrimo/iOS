//
//  CalendarController.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/19/21.
//

import UIKit
import EventKit

class CalendarController: UIViewController {
    
    // MARK: - Variables
    
    // MARK: - View Objects
    
    // MARK: - Overriden Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewConstraints()
        
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.darkBlue
        navigationItem.title = "Calendar".localized()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    // MARK: - Private Functions
    
    // MARK: - Objective-C Functions
    
}
