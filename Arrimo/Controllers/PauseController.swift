//
//  PauseController.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/24/21.
//

import UIKit
import CoreLocation

class PauseController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Variables
    
    var action : String? {
        didSet {
            actionLabel.text = action!.localized()
        }
    }
    
    var locationManager : CLLocationManager!
    
    // MARK: - View Objects
    
    private let infoLabel1 : UILabel = {
        let label = UILabel()
        label.font = UIFont.kufamBold(size: 18)!
        label.textColor = UIColor.secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.text = "You are currently on".localized()
        return label
    }()
    
    private let actionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.tekturBold(size: 35)!
        label.textColor = UIColor.darkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private let infoLabel2 : UILabel = {
        let label = UILabel()
        label.font = UIFont.kufamBold(size: 18)!
        label.numberOfLines = 2
        label.textColor = UIColor.secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.text = "Press 'Resume' to continue".localized()
        return label
    }()

    private let mainButton : MainButton = {
        let button = MainButton(title: "RESUME".localized())
        button.addTarget(self, action: #selector(mainButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // MARK: - Overriden Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationServices()
        updateViewConstraints()
        
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.darkBlue
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        view.addSubview(infoLabel1)
        infoLabel1.topAnchor.constraint(equalTo: view.topAnchor, constant: 70 + 88).isActive = true
        infoLabel1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        infoLabel1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        infoLabel1.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        view.addSubview(actionLabel)
        actionLabel.topAnchor.constraint(equalTo: infoLabel1.bottomAnchor, constant: 84).isActive = true
        actionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        actionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        actionLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        view.addSubview(infoLabel2)
        infoLabel2.topAnchor.constraint(equalTo: actionLabel.bottomAnchor, constant: 84).isActive = true
        infoLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel2.widthAnchor.constraint(equalToConstant: 275).isActive = true
        infoLabel2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(mainButton)
        mainButton.topAnchor.constraint(equalTo: infoLabel2.bottomAnchor, constant: 84).isActive = true
        mainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        mainButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
    }
    
    // MARK: - Private Functions
    
    private func locationServices() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if !CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func sendDictionary() {
        if locationManager.location?.coordinate == nil {
            locationManager.requestWhenInUseAuthorization()
        } else {
            sendJSON(action: "resume", long: locationManager.location!.coordinate.longitude, lat: locationManager.location!.coordinate.latitude)
            completion()
        }
    }
    
    private func completion() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Objective-C Functions
    
    @objc func mainButtonPressed() {
        // start loading
        showLoading()
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        hideLoading()
        sendDictionary()
    }

}
