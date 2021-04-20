//
//  WelcomeController.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/20/21.
//

import UIKit

class WelcomeController: UIViewController {
    
    // MARK: - View Objects
    
    private let appIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home-icon")!
        imageView.contentMode = UIView.ContentMode.scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkBlue
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.tekturBold(size: 22)
        return label
    }()
    
    private let divider1 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let mainButton : MainButton = {
        let button = MainButton(title: "Run My Day".localized())
        button.addTarget(self, action: #selector(mainButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // MARK: - Overriden Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backend()
        updateViewConstraints()
        
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        view.addSubview(appIcon)
        appIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14).isActive = true
        appIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        appIcon.widthAnchor.constraint(equalToConstant: 70).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        view.addSubview(welcomeLabel)
        welcomeLabel.topAnchor.constraint(equalTo: appIcon.bottomAnchor, constant: 27).isActive = true
        welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        welcomeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(divider1)
        divider1.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 23).isActive = true
        divider1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        divider1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(mainButton)
        mainButton.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 24).isActive = true
        mainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        mainButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
    }
    
    // MARK: - Private Functions
    
    private func backend() {
        let name = "nil"
        if name == "nil" {
            welcomeLabel.text = "Hello".localized()
        } else {
            welcomeLabel.text = "Hello".localized() + ", " + name
        }
    }
    
    // MARK: - Objective-C Functions
    
    @objc func mainButtonPressed() {
        // start loading
        showLoading()
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        hideLoading()
    }
    
    @objc func forgotPasswordPressed() {
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.soft)
        let controller = ForgotPasswordController()
        controller.modalPresentationStyle = .popover
        navigationController?.present(controller, animated: true, completion: nil)
    }

}
