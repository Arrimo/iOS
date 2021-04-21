//
//  ArrivedController.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/21/21.
//

import UIKit

class ArrivedController: UIViewController {
    
    // MARK: - Variables
    
    var user : String? {
        didSet {
            let destination = "Destination: ".localized()
            navigationItem.title = destination + user! + "'s House".localized()
        }
    }
    
    // MARK: - View Objects
    
    private let finishCommute : MainOrangeButton = {
        let button = MainOrangeButton(title: "ARRIVED AT\nDESTINATION".localized())
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.addTarget(self, action: #selector(mainButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let divider : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondaryGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let orLabel : UILabel = {
        let label = UILabel()
        label.text = "OR".localized()
        label.font = UIFont.kufamBold(size: 15)!
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.secondaryGray
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pauseButton : MainButton = {
        let button = MainButton(title: "PAUSE".localized())
        button.addTarget(self, action: #selector(pauseButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // MARK: - Overriden Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewConstraints()
        
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        view.addSubview(finishCommute)
        finishCommute.widthAnchor.constraint(equalToConstant: 250).isActive = true
        finishCommute.heightAnchor.constraint(equalToConstant: 250).isActive = true
        finishCommute.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 68).isActive = true
        finishCommute.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(divider)
        divider.topAnchor.constraint(equalTo: finishCommute.bottomAnchor, constant: 108).isActive = true
        divider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        divider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        view.addSubview(orLabel)
        orLabel.centerYAnchor.constraint(equalTo: divider.centerYAnchor).isActive = true
        orLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        orLabel.widthAnchor.constraint(equalToConstant: 66).isActive = true
        orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(pauseButton)
        pauseButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 71).isActive = true
        pauseButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        pauseButton.rightAnchor.constraint(equalTo: view.rightAnchor,  constant: -25).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
    }
    
    // MARK: - Private Functions
    
    private func backend(withId id: String) {
        //
        // set nav bar
    }
    
    // MARK: - Objective-C Functions
    
    @objc func pauseButtonPressed() {
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.soft)
        print("paused")
    }
    
    @objc func mainButtonPressed() {
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        print("finish commute")
    }

}