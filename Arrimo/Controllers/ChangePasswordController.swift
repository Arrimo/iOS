//
//  ChangePasswordController.swift
//  Arrimo
//
//  Created by JJ Zapata on 6/6/21.
//

import UIKit

class ChangePasswordController: UIViewController, UITextFieldDelegate {
    
    // MARK: - View Objects
    
    let oldPassword : MainTextField = {
        let textField = MainTextField(placeholderString: "Old Password".localized())
        textField.keyboardType = UIKeyboardType.default
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let newPassword : MainTextField = {
        let textField = MainTextField(placeholderString: "New Password".localized())
        textField.keyboardType = UIKeyboardType.default
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let newPasswordRepeated : MainTextField = {
        let textField = MainTextField(placeholderString: "Repeat New Password".localized())
        textField.keyboardType = UIKeyboardType.default
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let mainButton : MainButton = {
        let button = MainButton(title: "Change Password".localized())
        button.addTarget(self, action: #selector(mainButtonPressed), for: UIControl.Event.touchUpInside)
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
        
        title = "Change Password".localized()
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.darkBlue
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        view.addSubview(oldPassword)
        oldPassword.delegate = self
        oldPassword.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        oldPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        oldPassword.heightAnchor.constraint(equalToConstant: 44).isActive = true
        oldPassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(newPassword)
        newPassword.delegate = self
        newPassword.topAnchor.constraint(equalTo: oldPassword.bottomAnchor, constant: 11).isActive = true
        newPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        newPassword.heightAnchor.constraint(equalToConstant: 44).isActive = true
        newPassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(newPasswordRepeated)
        newPasswordRepeated.delegate = self
        newPasswordRepeated.topAnchor.constraint(equalTo: newPassword.bottomAnchor, constant: 11).isActive = true
        newPasswordRepeated.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        newPasswordRepeated.heightAnchor.constraint(equalToConstant: 44).isActive = true
        newPasswordRepeated.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true

        view.addSubview(mainButton)
        mainButton.topAnchor.constraint(equalTo: newPasswordRepeated.bottomAnchor, constant: 19).isActive = true
        mainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        mainButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
    }
    
    // MARK: - Private Functions
    
    // MARK: - Objective-C Functions
    
    @objc func mainButtonPressed() {
        // start loading
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        showLoading()
        if let old = oldPassword.text {
            if let new = newPassword.text, let newRepeated = newPasswordRepeated.text {
                if new == newRepeated {
                    APIManager.shared.changePassword(currentPassword: old, newPassword: new) { isSuccessful, response in
                        if isSuccessful {
                            self.hideLoading()
                            self.addSuccessNotification()
                            self.simpleAlert(title: "Success".localized(), message: response!)
                        } else {
                            self.hideLoading()
                            self.addErrorNotification()
                            self.simpleAlert(title: "Error".localized(), message: response!)
                        }
                    }
                } else {
                    hideLoading()
                    addErrorNotification()
                    simpleAlert(title: "Error".localized(), message: "New passwords do not match".localized())
                }
            } else {
                hideLoading()
                addErrorNotification()
                simpleAlert(title: "Error".localized(), message: "Please fill in all textfields".localized())
            }
        } else {
            hideLoading()
            addErrorNotification()
            simpleAlert(title: "Error".localized(), message: "Please fill in all textfields".localized())
        }
    }
    
    // MARK: - UITextField Delegation
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case oldPassword:
            newPassword.becomeFirstResponder()
        case newPassword:
            newPasswordRepeated.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
            mainButtonPressed()
        }
        return (true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
