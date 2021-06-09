//
//  SettingsController.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/19/21.
//

import UIKit
import SwiftKeychainWrapper

class SettingsController: UIViewController {
    
    // MARK: - Constants
    
    let version = "1.0.0"
    
    let language = "English".localized()
    
    // MARK: - View Objects
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let profileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.darkBlue
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        return imageView
    }()
    
    let titleName : UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.tekturSemiBold(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let restaurantName : UILabel = {
        let label = UILabel()
        label.text = "Arrimo Digital"
        label.textColor = UIColor.darkBlue
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.tekturSemiBold(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let versionImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rocet")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let languageImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "language")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let rateUsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let reportErrorImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let requestFeatureImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "feature")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let shareDishImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "share")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let signOutImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logout")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let versionTitle : UILabel = {
        let label = UILabel()
        label.text = "Version".localized()
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.kufamSemiBold(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let versionDesc : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryGray
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.kufamSemiBold(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let languageTitle : UILabel = {
        let label = UILabel()
        label.text = "Language".localized()
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.kufamSemiBold(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let languageDesc : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryGray
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.kufamSemiBold(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rateUsTitle : UILabel = {
        let label = UILabel()
        label.text = "Give Feedback".localized()
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.kufamSemiBold(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let requestFeatureTitle : UILabel = {
        let label = UILabel()
        label.text = "Change Password".localized()
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.kufamSemiBold(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let signOutTitle : UILabel = {
        let label = UILabel()
        label.text = "Sign Out".localized()
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.kufamSemiBold(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let chevron1 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.darkBlue
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let chevron2 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.darkBlue
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let chevron3 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.darkBlue
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let chevron4 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.darkBlue
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let chevron5 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.darkBlue
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let chevron6 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.darkBlue
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let button1 : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(button1Tapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let button2 : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(button2Tapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let button3 : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(button3Tapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // MARK: - Overriden Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
        updateViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.darkBlue
        
        backend()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        constraints()
    }
    
    // MARK: - Private Functions
    
    private func constraints() {
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.width - 50, height: 500)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        scrollView.addSubview(profileImage)
        profileImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 7).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        scrollView.addSubview(titleName)
        titleName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 19).isActive = true
        titleName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        titleName.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 50).isActive = true
        
        scrollView.addSubview(restaurantName)
        restaurantName.topAnchor.constraint(equalTo: titleName.bottomAnchor).isActive = true
        restaurantName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        restaurantName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        restaurantName.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 50).isActive = true
        
        scrollView.addSubview(versionImage)
        versionImage.topAnchor.constraint(equalTo: restaurantName.bottomAnchor, constant: 48).isActive = true
        versionImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        versionImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        versionImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        scrollView.addSubview(languageImage)
        languageImage.topAnchor.constraint(equalTo: versionImage.bottomAnchor, constant: 15).isActive = true
        languageImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        languageImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        languageImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        scrollView.addSubview(rateUsImage)
        rateUsImage.topAnchor.constraint(equalTo: languageImage.bottomAnchor, constant: 30).isActive = true
        rateUsImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        rateUsImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        rateUsImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        scrollView.addSubview(requestFeatureImage)
        requestFeatureImage.topAnchor.constraint(equalTo: rateUsImage.bottomAnchor, constant: 15).isActive = true
        requestFeatureImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        requestFeatureImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        requestFeatureImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        scrollView.addSubview(signOutImage)
        signOutImage.topAnchor.constraint(equalTo: requestFeatureImage.bottomAnchor, constant: 30).isActive = true
        signOutImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        signOutImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        signOutImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        scrollView.addSubview(versionTitle)
        versionTitle.topAnchor.constraint(equalTo: restaurantName.bottomAnchor, constant: 48).isActive = true
        versionTitle.leftAnchor.constraint(equalTo: versionImage.rightAnchor, constant: 12).isActive = true
        versionTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true
        versionTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true

        scrollView.addSubview(languageTitle)
        languageTitle.topAnchor.constraint(equalTo: languageImage.topAnchor).isActive = true
        languageTitle.leftAnchor.constraint(equalTo: languageImage.rightAnchor, constant: 12).isActive = true
        languageTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true
        languageTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true

        scrollView.addSubview(versionDesc)
        versionDesc.text = version
        versionDesc.topAnchor.constraint(equalTo: restaurantName.bottomAnchor, constant: 48).isActive = true
        versionDesc.leftAnchor.constraint(equalTo: versionImage.rightAnchor, constant: 12).isActive = true
        versionDesc.heightAnchor.constraint(equalToConstant: 35).isActive = true
        versionDesc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true

        scrollView.addSubview(languageDesc)
        languageDesc.text = language
        languageDesc.topAnchor.constraint(equalTo: languageImage.topAnchor).isActive = true
        languageDesc.leftAnchor.constraint(equalTo: languageImage.rightAnchor, constant: 12).isActive = true
        languageDesc.heightAnchor.constraint(equalToConstant: 35).isActive = true
        languageDesc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true

        scrollView.addSubview(rateUsTitle)
        rateUsTitle.topAnchor.constraint(equalTo: rateUsImage.topAnchor).isActive = true
        rateUsTitle.leftAnchor.constraint(equalTo: rateUsImage.rightAnchor, constant: 12).isActive = true
        rateUsTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true
        rateUsTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true

        scrollView.addSubview(requestFeatureTitle)
        requestFeatureTitle.topAnchor.constraint(equalTo: requestFeatureImage.topAnchor).isActive = true
        requestFeatureTitle.leftAnchor.constraint(equalTo: requestFeatureImage.rightAnchor, constant: 12).isActive = true
        requestFeatureTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true
        requestFeatureTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true

        scrollView.addSubview(signOutTitle)
        signOutTitle.topAnchor.constraint(equalTo: signOutImage.topAnchor).isActive = true
        signOutTitle.leftAnchor.constraint(equalTo: signOutImage.rightAnchor, constant: 12).isActive = true
        signOutTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true
        signOutTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        scrollView.addSubview(chevron3)
        chevron3.centerYAnchor.constraint(equalTo: rateUsImage.centerYAnchor).isActive = true
        chevron3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        chevron3.widthAnchor.constraint(equalToConstant: 15).isActive = true
        chevron3.heightAnchor.constraint(equalToConstant: 15).isActive = true

        scrollView.addSubview(chevron4)
        chevron4.centerYAnchor.constraint(equalTo: rateUsImage.centerYAnchor).isActive = true
        chevron4.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        chevron4.widthAnchor.constraint(equalToConstant: 15).isActive = true
        chevron4.heightAnchor.constraint(equalToConstant: 15).isActive = true

        scrollView.addSubview(chevron5)
        chevron5.centerYAnchor.constraint(equalTo: requestFeatureImage.centerYAnchor).isActive = true
        chevron5.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        chevron5.widthAnchor.constraint(equalToConstant: 15).isActive = true
        chevron5.heightAnchor.constraint(equalToConstant: 15).isActive = true

        scrollView.addSubview(chevron6)
        chevron6.centerYAnchor.constraint(equalTo: signOutImage.centerYAnchor).isActive = true
        chevron6.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        chevron6.widthAnchor.constraint(equalToConstant: 15).isActive = true
        chevron6.heightAnchor.constraint(equalToConstant: 15).isActive = true

        scrollView.addSubview(button1)
        button1.topAnchor.constraint(equalTo: rateUsImage.topAnchor).isActive = true
        button1.leftAnchor.constraint(equalTo: rateUsImage.leftAnchor).isActive = true
        button1.rightAnchor.constraint(equalTo: chevron3.rightAnchor).isActive = true
        button1.bottomAnchor.constraint(equalTo: rateUsImage.bottomAnchor).isActive = true

        scrollView.addSubview(button2)
        button2.topAnchor.constraint(equalTo: requestFeatureImage.topAnchor).isActive = true
        button2.leftAnchor.constraint(equalTo: requestFeatureImage.leftAnchor).isActive = true
        button2.rightAnchor.constraint(equalTo: chevron4.rightAnchor).isActive = true
        button2.bottomAnchor.constraint(equalTo: requestFeatureImage.bottomAnchor).isActive = true

        scrollView.addSubview(button3)
        button3.topAnchor.constraint(equalTo: signOutImage.topAnchor).isActive = true
        button3.leftAnchor.constraint(equalTo: signOutImage.leftAnchor).isActive = true
        button3.rightAnchor.constraint(equalTo: chevron5.rightAnchor).isActive = true
        button3.bottomAnchor.constraint(equalTo: signOutImage.bottomAnchor).isActive = true
    }
    
    private func backend() {
        profileImage.image = UIImage(named: RunningInfo.shared.caretaker!.gender!)
        titleName.text = RunningInfo.shared.caretaker!.firstName! + " " + RunningInfo.shared.caretaker!.lastName!
    }
    
    // MARK: - Objective-C Functions
    
    @objc func button1Tapped() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1563805413") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func button2Tapped() {
        let controller = ChangePasswordController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func button3Tapped() {
        let alert = UIAlertController(title: "Sign Out?".localized(), message: "Are you sure you want to sign out?".localized(), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes".localized(), style: .default, handler: { (action) in
            KeychainWrapper.standard.removeObject(forKey: "accessToken")
            KeychainWrapper.standard.removeObject(forKey: "userId")
            let controller = SignInController()
            controller.viewDidLoad()
            controller.updateViewConstraints()
            controller.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.present(controller, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No".localized(), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
}
