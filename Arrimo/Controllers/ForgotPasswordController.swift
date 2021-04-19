//
//  ForgotPasswordController.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/19/21.
//

import UIKit

class ForgotPasswordController: UIViewController, UITextFieldDelegate {
    
    // MARK: - View Objects
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Forgot Password?".localized()
        label.textColor = UIColor.darkBlue
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.tekturBold(size: 22)
        return label
    }()
    
    private let emailTextField : MainTextField = {
        let textField = MainTextField(placeholderString: "Email".localized())
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        return textField
    }()
    
    private let mainButton : MainButton = {
        let button = MainButton(title: "Send Link".localized())
        button.addTarget(self, action: #selector(mainButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // MARK: - Overriden Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        emailTextField.becomeFirstResponder()
        emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 53).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(mainButton)
        mainButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 36).isActive = true
        mainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        mainButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
    }
    
    // MARK: - Objective-C Functions
    
    @objc func mainButtonPressed() {
        // start loading
        showLoading()
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        if emailTextField.text != "" {
            hideLoading()
            // throw sign in function
                // haptics
                // alerts
            simpleAlert(title: "Success".localized(), message: "A password reset link has been sent.".localized())
        } else {
            hideLoading()
            addErrorNotification()
            simpleAlert(title: "Error".localized(), message: "Please fill in the email text field.".localized())
        }
    }
    
    // MARK: - UITextField Delegation
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        mainButtonPressed()
        return (true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
