//
//  ViewController.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/15/21.
//

import UIKit

class SignInController: UIViewController, UITextFieldDelegate {
    
    // MARK: - View Objects
    
    private let appIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home-icon")!
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let signInLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign In".localized()
        label.textColor = UIColor.darkBlue
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.tekturBold(size: 22)
        return label
    }()
    
    private let emailTextField : MainTextField = {
        let textField = MainTextField(placeholderString: "Email".localized())
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.autocorrectionType = UITextAutocorrectionType.yes
        return textField
    }()
    
    private let passwordTextField : MainTextField = {
        let textField = MainTextField(placeholderString: "Password".localized())
        textField.keyboardType = UIKeyboardType.default
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let forgotPasswordButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Forgot Password?".localized(), for: UIControl.State.normal)
        button.setTitleColor(UIColor.darkBlue, for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.kufamBold(size: 12)
        button.titleLabel?.textAlignment = NSTextAlignment.right
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        button.addTarget(self, action: #selector(forgotPasswordPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let mainButton : MainButton = {
        let button = MainButton(title: "Sign In".localized())
        button.addTarget(self, action: #selector(mainButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // MARK: - Overriden Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoLogin()
        
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
        
        view.addSubview(signInLabel)
        signInLabel.topAnchor.constraint(equalTo: appIcon.bottomAnchor, constant: 27).isActive = true
        signInLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        signInLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        signInLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        emailTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 53).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 11).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 19).isActive = true
        forgotPasswordButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        forgotPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        view.addSubview(mainButton)
        mainButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 36).isActive = true
        mainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        mainButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
    }
    
    // MARK: - Private Functions
    
    func autoLogin() {
        //
    }
    
    // MARK: - Objective-C Functions
    
    @objc func mainButtonPressed() {
        // start loading
        showLoading()
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.light)
        if emailTextField.text != "" && passwordTextField.text != "" {
            hideLoading()
            addSuccessNotification()
            simpleAlert(title: "Success".localized(), message: "A password reset link has been sent.".localized())
        } else {
            hideLoading()
            addErrorNotification()
            simpleAlert(title: "Error".localized(), message: "Please fill in all fields.".localized())
        }
    }
    
    @objc func forgotPasswordPressed() {
        add3DMotion(withFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle.soft)
        let controller = ForgotPasswordController()
        controller.modalPresentationStyle = .popover
        navigationController?.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - UITextField Delegation
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            mainButtonPressed()
        default:
            textField.resignFirstResponder()
        }
        return (true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}









































